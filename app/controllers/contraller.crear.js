import pool from "../config/mysql.db.js";
import { success, error } from "../messages/browser.js";

// Función para mapear texto a valor_respuesta_id
function obtenerValorRespuestaId(texto) {
    const textoLower = texto?.toLowerCase().trim();
    switch (textoLower) {
        case 'siempre':
            return 1;
        case 'a veces':
        case 'aveces':
            return 2;
        case 'nunca':
            return 3;
        default:
            return null; // Valor no válido
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

        // 1. Crear cabecera
        const [result] = await conn.query(
            `CALL SP_CREAR_EVALUACIONES_REALIZADAS(?, ?, ?, ?, ?)`,
            [fechaEvaluacion, nombreEvaluado, cargoEvaluado, nombreEvaluador, cargoEvaluador]
        );

        // 2. Obtener el ID insertado
        const [[lastInsert]] = await conn.query(`SELECT LAST_INSERT_ID() AS evaluacion_realizada_id`);
        const evaluacion_realizada_id = lastInsert.evaluacion_realizada_id;

        // 3. Unificar y recorrer todas las respuestas
        const todas = [
            ...respuestas.objetivo,
            ...respuestas.corporativas,
            ...respuestas.blandas,
        ];

        for (const r of todas) {
            const valor_id = r.valor_respuesta_id || obtenerValorRespuestaId(r.respuesta);
            if (!valor_id) {
                throw new Error(`Respuesta inválida o no mapeada: "${r.respuesta}"`);
            }

            await conn.query(
                `CALL SP_CREAR_RESPUESTA(?, ?, ?, ?)`,
                [usuario_id, r.pregunta_id, evaluacion_realizada_id, valor_id]
            );
        }

        await conn.commit();
        success(req, res, 200, "Evaluación registrada correctamente.");
    } catch (err) {
        await conn.rollback();
        error(req, res, 500, err.message);
    } finally {
        conn.release();
    }
};

export { guardarEvaluacionCompleta };
