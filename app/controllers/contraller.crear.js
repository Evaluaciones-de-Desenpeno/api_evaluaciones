import pool from "../config/mysql.db";
import {success, error} from "../messages/browser";
import { config } from "dotenv";

config();


const crearrespuesta = async (req,res) => {
    const { usuario_id, evaluacion_id, evaluacion_realizada_id, valor_respuesta_id, respuesta} = req.body;
    if (!usuario_id || !evaluacion_id || !evaluacion_realizada_id || !valor_respuesta_id) {
        return error(req, res, 400, "Todos los campos son obligatorios");
    }
    try {
        const [respuesta] = await pool.query(`CALL SP_CREAR_RESPUESTA(?, ?, ?, ?, ?);`, [usuario_id, evaluacion_id, evaluacion_realizada_id, valor_respuesta_id, respuesta]);
        success(req, res, 200, respuesta[0]);
    } catch (err) {
        error(req, res, 500, err);
    }
}



export {};