import pool from "../config/mysql.db.js";
import { success, error } from "../messages/browser.js";

const guardarEvaluacionCompleta = async (req, res) => {
    const {
        nombreEvaluado,
        cargoEvaluado,
        nombreEvaluador,
        cargoEvaluador,
        fechaEvaluacion,
        respuestas,
    } = req.body;

    const usuario_id = req.user?.usuario_id || 1; // Puedes ajustar según token

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

        // Obtener el ID insertado desde evaluaciones_realizadas
        const [[lastInsert]] = await conn.query(`SELECT LAST_INSERT_ID() AS evaluacion_realizada_id`);
        const evaluacion_realizada_id = lastInsert.evaluacion_realizada_id;

        // 2. Insertar respuestas (unificando todas)
        const todas = [...respuestas.objetivo, ...respuestas.corporativas, ...respuestas.blandas];

        for (const r of todas) {
            // Por ahora, asumimos valor_respuesta_id = null
            await conn.query(
                `CALL SP_CREAR_RESPUESTA(?, ?, ?, ?, ?)`,
                [usuario_id, r.pregunta_id, evaluacion_realizada_id, r.valor_respuesta_id || 0, r.respuesta]
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