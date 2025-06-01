import { Router } from "express";
import { guardarEvaluacionCompleta } from "../controllers/contraller.crear.js";


const rutaCrear = Router();

rutaCrear.post("/guardar", guardarEvaluacionCompleta);

export default rutaCrear;
