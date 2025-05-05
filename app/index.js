import app from './app.js';
import { msjConsole, mensa } from  "./messages/consola.js";


app.listen(app.get("PORT"), () => {
    msjConsole("puertoSuccess",
     `${mensa.puerto} ${app.get("PORT")} http://localhost:${app.get("PORT")}`);
});