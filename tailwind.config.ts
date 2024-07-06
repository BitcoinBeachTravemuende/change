import type { Config } from "tailwindcss";

export default {
  darkMode: "selector",
  content: ["./src/**/*.{js,elm,ts,css,html}"],
  theme: {
    extend: {},
  },
  plugins: [],
} satisfies Config;
