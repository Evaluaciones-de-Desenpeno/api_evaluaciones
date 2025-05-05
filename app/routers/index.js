import { Router } from "express";
import { messageBrowse } from "../messages/browser.js";


const ruta = Router();




ruta.use("/", (req, res) => {res.json({"respuesta": messageBrowse.principal})});


export default ruta;