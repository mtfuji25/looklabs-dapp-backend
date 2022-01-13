class PlayerActions {
    //
    //  Frontend actions mapping
    //  "attackright": 0, "attackleft": 1,
    //  "attackup": 2, "attackdown": 3,
    //  "walkright": 4, "walkleft": 5,
    //  "walkup": 6, "walkdown": 7
    //
        static DIRECTION_UP:string = "up";
        static DIRECTION_DOWN:string = "down";
        static DIRECTION_RIGHT:string = "right";
        static DIRECTION_LEFT:string = "left";
    
        static ATTACK_RIGHT:number = 0;
        static ATTACK_LEFT:number = 1;
        static ATTACK_UP:number = 2;
        static ATTACK_DOWN:number = 3;
    
        static WALK_RIGHT:number = 4;    
        static WALK_LEFT:number = 5;
        static WALK_UP:number = 6;
        static WALK_DOWN:number = 7;
    
        static ATTACK_RIGHT_CRITICAL:number = 10;
        static ATTACK_LEFT_CRITICAL:number = 11;
    
        static ATTACK_UP_CRITICAL:number = 12;
        static ATTACK_DOWN_CRITICAL:number = 13;
    
        static WALK_RIGHT_HEALING:number = 24;
        static WALK_LEFT_HEALING:number = 25;
        
        static WALK_UP_HEALING:number = 26;
        static WALK_DOWN_HEALING:number = 27;
        
    
    }
    
    export { PlayerActions }