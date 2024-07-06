import "./styles.css";
import { Elm } from "./src/Main.elm";

// -- THEME

const setDark = (isDark: boolean) => {
  const htmlClass = document.querySelector("html")?.classList;
  if (isDark) htmlClass?.add("dark");
  else htmlClass?.remove("dark");
};

const initialTheme = // check LS
  window.localStorage.theme ||
  // or check system's color scheme
  (window.matchMedia("(prefers-color-scheme: dark)").matches
    ? "dark"
    : "light");

// -- APP

let app = Elm.Main.init({
  node: document.getElementById("app"),
  flags: { theme: initialTheme },
});

setDark(initialTheme === "dark");

// -- PORTS

app.ports.interopFromElm.subscribe((fromElm) => {
  switch (fromElm.tag) {
    case "saveTheme":
      window.localStorage["theme"] = fromElm.data;
      break;
    case "setDarkMode": {
      setDark(fromElm.data);
      break;
    }
  }
});
