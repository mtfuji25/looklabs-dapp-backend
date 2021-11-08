
type OnDieFn = () => (void);

class StatusComponent {
    public health: number = 0;
    public defense: number = 0;

    public onSelfDie: OnDieFn = () => {};
    public notifyHunter: OnDieFn = () => {};

    constructor(health: number, defense: number) {
        this.health = health;
        this.defense = defense;
    }

    hit(attack: number) {
        let damage = attack;

        // Checks for critical hit, 8% of chance
        if (Math.random() < 0.08) {
            damage += Math.random() * 30;
        } else {
            // Checks for miss hit, 15% of chance
            if (Math.random() < 0.1) {
                damage -= Math.random() * 30;
            }
        }

        // Not allow negative damage
        if (damage < 0)
            damage = 1;

        if (this.defense >= damage) {
            this.health -= 1;
        } else {
            this.health -= (damage - this.defense);
        }
    }

    onDie() {
        this.onSelfDie();
        this.notifyHunter();
    }
}

export { StatusComponent };
