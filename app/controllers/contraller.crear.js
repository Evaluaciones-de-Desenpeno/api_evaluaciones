import pool from "../config/mysql.db.js";
import ExcelJS from "exceljs";
import { success, error } from "../messages/browser.js";

// Función para mapear texto a valor_respuesta_id
function obtenerValorRespuestaId(texto) {
    const textoLower = texto?.toLowerCase().trim();
    switch (textoLower) {
        case 'siempre': return 1;
        case 'a veces':
        case 'aveces': return 2;
        case 'nunca': return 3;
        default: return null;
    }
}

const guardarEvaluacionCompleta = async (req, res) => {
    const {
        nombreEvaluado,
        cargoEvaluado,
        nombreEvaluador,
        cargoEvaluador,
        fechaEvaluacion,
        respuestas,
    } = req.body;

    const usuario_id = req.user?.usuario_id || 1;

    if (!fechaEvaluacion || !nombreEvaluado || !cargoEvaluado || !nombreEvaluador || !cargoEvaluador || !respuestas) {
        return error(req, res, 400, "Faltan datos de la evaluación.");
    }

    const conn = await pool.getConnection();
    try {
        await conn.beginTransaction();

        // 1. Crear cabecera de evaluación realizada
        await conn.query(
            `CALL SP_CREAR_EVALUACIONES_REALIZADAS(?, ?, ?, ?, ?)`,
            [fechaEvaluacion, nombreEvaluado, cargoEvaluado, nombreEvaluador, cargoEvaluador]
        );

        // 2. Obtener ID generado
        const [[{ evaluacion_realizada_id }]] = await conn.query(`SELECT LAST_INSERT_ID() AS evaluacion_realizada_id`);

        // 3. Función interna para procesar cada grupo de respuestas
        const procesarRespuestas = async (respuestasArray, tipoEvaluacion) => {
            for (const r of respuestasArray) {
                const valor_id = r.valor_respuesta_id || obtenerValorRespuestaId(r.respuesta);
                if (!valor_id) {
                    throw new Error(`Respuesta inválida o no mapeada: "${r.respuesta}"`);
                }

                let competencia_pregunta_id = null;
                let objetivo_pregunta_id = null;
                let evaluacion_id = null;

                if (tipoEvaluacion === 'objetivo') {
                    objetivo_pregunta_id = r.pregunta_id; // Debe ser el ID de objetivos_preguntas
                    evaluacion_id = 1; // ID fijo para objetivos
                } else if (tipoEvaluacion === 'corporativas') {
                    competencia_pregunta_id = r.pregunta_id; // Debe ser el ID de evaluación para corporativas
                    evaluacion_id = 2;
                } else if (tipoEvaluacion === 'blandas') {
                    competencia_pregunta_id = r.pregunta_id; // ID de evaluación para blandas
                    evaluacion_id = 3;
                }

                await conn.query(
                    `CALL SP_CREAR_RESPUESTA(?, ?, ?, ?, ?, ?)`,
                    [
                        usuario_id,
                        evaluacion_id,
                        evaluacion_realizada_id,
                        competencia_pregunta_id,
                        objetivo_pregunta_id,
                        valor_id
                    ]
                );
            }
        };

        // 4. Procesar respuestas por tipo
        if (Array.isArray(respuestas.objetivo) && respuestas.objetivo.length > 0) {
            await procesarRespuestas(respuestas.objetivo, 'objetivo');
        }

        if (Array.isArray(respuestas.corporativas) && respuestas.corporativas.length > 0) {
            await procesarRespuestas(respuestas.corporativas, 'corporativas');
        }

        if (Array.isArray(respuestas.blandas) && respuestas.blandas.length > 0) {
            await procesarRespuestas(respuestas.blandas, 'blandas');
        }

        await conn.commit();
        success(req, res, 200, "✅ Evaluación guardada correctamente.");
    } catch (err) {
        await conn.rollback();
        console.error("❌ Error al guardar evaluación:", err);
        error(req, res, 500, err.message);
    } finally {
        conn.release();
    }
};


// exportar infromacion

const exportarRespuestasExcel = async (req, res) => {
    try {
        const [rows] = await pool.query(`CALL SP_OBTENER_RESPUESTAS_COMPLETAS()`);

        // ExcelJS: crear libro y hoja
        const workbook = new ExcelJS.Workbook();
        const worksheet = workbook.addWorksheet("Evaluaciones");

        // Cabeceras
        worksheet.columns = [
            { header: "ID Respuesta", key: "respuestas_id", width: 15 },
            // { header: "Usuario", key: "nombre_usuario", width: 20 },
            // { header: "Pregunta General", key: "pregunta_general", width: 40 },
            { header: "Fecha Evaluación", key: "fecha", width: 20 },
            { header: "Nombre Evaluado", key: "nombre_evaluado", width: 25 },
            { header: "Cargo Evaluado", key: "cargo_evaluado", width: 25 },
            { header: "Nombre Evaluador", key: "nombre_evaluador", width: 25 },
            { header: "Cargo Evaluador", key: "cargo_evaluador", width: 25 },
            { header: "Competencia", key: "nombre_competencia", width: 25 },
            { header: "Pregunta Competencia", key: "pregunta_competencia", width: 40 },
            { header: "Objetivo", key: "nombre_objetivo", width: 30 },
            { header: "Pregunta Objetivo", key: "pregunta_objetivo", width: 40 },
            { header: "Valor", key: "valor_respuesta", width: 10 },
        ];

        // Agregar filas
        rows[0].forEach((row) => worksheet.addRow(row));

        // Encabezados de descarga
        res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        res.setHeader("Content-Disposition", "attachment; filename=respuestas_evaluaciones.xlsx");

        // Enviar archivo Excel
        await workbook.xlsx.write(res);
        res.end();
    } catch (err) {
        console.error("Error al exportar Excel:", err);
        res.status(500).json({ error: "Error al exportar respuestas a Excel" });
    }
};



export { guardarEvaluacionCompleta, exportarRespuestasExcel };