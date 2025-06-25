import { Router } from "express";
import { exportarRespuestasExcel, guardarEvaluacionCompleta } from "../controllers/contraller.crear.js";


const rutaCrear = Router();

rutaCrear.post("/guardar", guardarEvaluacionCompleta);
rutaCrear.get("/exportar", exportarRespuestasExcel);

export default rutaCrear;
