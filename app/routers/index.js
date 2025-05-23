import { Router } from "express";
import { messageBrowse } from "../messages/browser.js";
import rutausuario from "./usuario.routes.js";
import rutamostrar from "./general.routes.js";


const ruta = Router();

ruta.use("/user", rutausuario);
ruta.use("/evaluacion", rutamostrar);


ruta.use("/", (req, res) => {res.json({"respuesta": messageBrowse.principal})});


export default ruta;