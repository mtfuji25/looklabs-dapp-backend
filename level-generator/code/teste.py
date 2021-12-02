import random

step = 0.038
stop = -0.38

for i in range(20):
    print(f"new Vec2({stop + i * step}, { -0.2758 + (1 if random.random() < 0.5 else -1) * random.random() * 0.038 }),")