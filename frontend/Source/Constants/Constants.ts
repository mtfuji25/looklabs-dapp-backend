// Path to static files
const STATIC_URL = "./public";

// WebSocket Client configs
const WS_HOST = process.env.WS_SERVER_HOST || "ws:localhost:8082";

// Strapi Client configs
const STRAPI_HOST = "https://the-pit-cloud-3fiy6wgliq-nw.a.run.app/";

// Canva view div id
const ROOT_DIV_ID = "#root";

// Default background color
const MAIN_BG_COLOR = 0x18215d;

// Container's dimesnsion
const CONTAINER_DIM = 1440;

// Unit sprite size
const SPRITE_SIZE = 16;

export { STATIC_URL, WS_HOST, STRAPI_HOST, ROOT_DIV_ID, MAIN_BG_COLOR, CONTAINER_DIM, SPRITE_SIZE };
