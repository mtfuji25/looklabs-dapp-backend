import { inputs, KEYS, BTNS } from "../inputs/inputs";

let melao = 100;

class Teste {
    constructor(app) {
        melao = 100;
    }

    onAttach() {
    }

    onUpdate(deltaTime) {
        if (inputs.key[KEYS.W]) {
            melao -= 1;
        }
        if (inputs.key[KEYS.S]) {
            melao += 1;
        }
    }

    getUiStatus() {
        return {
            life: melao
        }
    }
}

export { Teste };