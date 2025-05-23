import pool from "../config/mysql.db";
import {success, error} from "../messages/browser";
import { config } from "dotenv";


config();

const mostrarvalorrespuesta = async (req,res) => {
    try {
        const [respuesta] = await pool.query(`CALL SP_MOSTRAR_VALOR_RESPUESTA();`);
        success(req, res, 200, respuesta[0]);
    } catch (err) {
        error(req, res, 500, err);
    }

};

const mostrarevaluaciones = async (req,res) => {
    const { rol_id } = req.query;
    if (!rol_id) {
        return error(req, res, 400, "El rol_id es obligatorio");
    }
    try {
        const [respuesta] = await pool.query(`CALL SP_MOSTRAR_EVALUACIONES();`);
        success(req, res, 200, respuesta[0]);
    } catch (err) {
        error(req, res, 500, err);
    }
};

const mostrarobjetivo = async (req,res) => {
    const { rol_id } = req.query;
    if (!rol_id) {
        return error(req, res, 400, "El rol_id es obligatorio");
    }
    try {
        const [respuesta] = await pool.query(`CALL SP_MOSTRAR_OBJETIVO(${rol_id});`);
        success(req, res, 200, respuesta[0]);
    } catch (err) {
        error(req, res, 500, err);
    }
};

const mostrarobjetivopregunta = async (req,res) => {
    const { objetivo_id } = req.query;
    if (!objetivo_id) {
        return error(req, res, 400, "El objetivo_id es obligatorio");
    }
    try {
        const [respuesta] = await pool.query(`CALL SP_MOSTRAR_OBJETIVO_PREGUNTAS(${objetivo_id});`);
        success(req, res, 200, respuesta[0]);
    } catch (err) {
        error(req, res, 500, err);
    }
};

const mostrarcompetencia = async (req,res) => {
    const { rol_id } = req.query;
    if (!rol_id) {
        return error(req, res, 400, "El rol_id es obligatorio");
    }
    try {
        const [respuesta] = await pool.query(`CALL SP_MOSTRAR_COMPETENCIA(${rol_id});`);
        success(req, res, 200, respuesta[0]);
    } catch (err) {
        error(req, res, 500, err);
    }
};


const mostrarcompetenciapregunta = async (req,res) => {
    const { competencia_id } = req.query;
    if (!competencia_id) {
        return error(req, res, 400, "El competencia_id es obligatorio");
    }
    try {
        const [respuesta] = await pool.query(`CALL SP_MOSTRAR_COMPETENCIA_PREGUNTAS(${competencia_id});`);
        success(req, res, 200, respuesta[0]);
    } catch (err) {
        error(req, res, 500, err);
    }
};





export {mostrarvalorrespuesta, mostrarevaluaciones, mostrarobjetivo, mostrarobjetivopregunta, mostrarcompetencia, mostrarcompetenciapregunta};