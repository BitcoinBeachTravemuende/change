import "./styles.css";
import Main from "./src/Main.elm";

// -- THEME

const setDark = (isDark) => {
  const htmlClass = document.querySelector("html")?.classList;
  if (isDark) htmlClass?.add("dark");
  else htmlClass?.remove("dark");
};

const initialTheme = // check LS
  window.localStorage.theme ??
  // or check system's color scheme
  (window.matchMedia("(prefers-color-scheme: dark)").matches
    ? "dark"
    : "light");

// -- APP

let app = Main.init({
  node: document.getElementById("app"),
  flags: initialTheme,
});

setDark(initialTheme === "dark");

// -- PORTS

app?.ports?.setDarkMode.subscribe(setDark);

app?.ports?.saveLocalStorage.subscribe(({ key, value }) => {
  window.localStorage[key] = value;
});
