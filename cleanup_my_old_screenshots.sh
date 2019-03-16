comm -23 <(ls -U | grep Selec | sort) <(ls -U | grep Selec | sort | tail -20) | xargs -I {} rm {}
