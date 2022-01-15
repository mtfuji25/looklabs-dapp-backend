// Path to static files
const STATIC_URL = "./public";

// WebSocket Client configs
const WS_HOST = process.env.WS_SERVER_HOST;
const WS_PORT = Number(process.env.WS_SERVER_PORT);
// Strapi Client configs
const STRAPI_SERVER_HOST = process.env.STRAPI_SERVER_HOST;
const STRAPI_BEARER_TOKEN = process.env.STRAPI_BEARER_TOKEN;

const LOGGER_LEVEL = Number("0b" + process.env.LOGGER_LEVEL);

// Canva view div id
const ROOT_DIV_ID = "#root";

// Default background color
const MAIN_BG_COLOR = 0x18215d;

// Container's dimesnsion
const CONTAINER_DIM_X = 1856;
const CONTAINER_DIM_Y = 1856;

// Unit sprite size
const SPRITE_SIZE = 16;

export {
    STATIC_URL,
    WS_HOST,
    WS_PORT,
    STRAPI_SERVER_HOST,
    STRAPI_BEARER_TOKEN,
    ROOT_DIV_ID,
    MAIN_BG_COLOR,
    CONTAINER_DIM_X,
    CONTAINER_DIM_Y,
    SPRITE_SIZE,
    LOGGER_LEVEL
};
