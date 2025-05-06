import { Router } from "express";
import { messageBrowse } from "../messages/browser.js";
import rutausuario from "./usuario.routes.js";


const ruta = Router();

ruta.use("/user", rutausuario);


ruta.use("/", (req, res) => {res.json({"respuesta": messageBrowse.principal})});


export default ruta;