import { Router } from "express";
import { mostrarcompetencia, mostrarcompetenciapregunta, mostrarevaluaciones, mostrarobjetivo, mostrarobjetivopregunta, mostrarvalorrespuesta } from "../controllers/controller.mostrar";


const rutamostrar = Router();

rutamostrar.get("/valorrespuesta", mostrarvalorrespuesta);
rutamostrar.get("/evapregunta", mostrarevaluaciones);
rutamostrar.get("/objetivo", mostrarobjetivo);
rutamostrar.get("/objepregunta", mostrarobjetivopregunta);
rutamostrar.get("/competencia", mostrarcompetencia);
rutamostrar.get("/compepregunta", mostrarcompetenciapregunta);


export default rutamostrar;