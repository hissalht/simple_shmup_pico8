# todo
- [ ] vertical UI
    - [x] ui feedback : I feel health is not legible
    - remaining space on top of the bar for the rest of infos
        - score
        - wave counter
    - [ ] implement ui prototype (functionnal)
    - [ ] implement ui skin
- [ ] integrate new enemies types
- [ ] quick fix collision between ship and border of screen
- [x] laser shot v1
- [ ] laser improvements
    - [x] build up in size
    - [x] stop on enemies
    - [x] concentrated laser at origin
        - [x] and end
    - [ ] particle effect to give movement to the chunk of the laser
    - [ ] particles at begining and end
- [x] introduce weapon damage
- [x] win screen
    - button lockout to avoid skipping it
- change hit impact
- [ ] program particles for ship engine
- [ ] fix : hit impact stop animating on wave screen
- [x] recheck hitbox matching
- [x] update ship sprite
- [ ] improve muzzle flash
    - see lizenn proposal, I can maybe program sth similar with a bunch of shrinking ovals


- [x] fix lag shot button
- [x] broken asteroid
- [x] implement better explosions
- [x] improve basic bullet cause it sux rn
- [x] fix invul drawing
- [x] give health to enemies
    - [x] add some hit effect
    - [x] add blink when enemy get hit
- [x] polish hit effect
    - [x] add sparks (ep 16 on shockwaves) / hit + destruction
- [x] make the explosion bigger
- [x] position hit effect properly
- [x] debug draw hitbox mode
- [x] postion hit boxes properly
    - [x] size adjust
    - [x] update collision code
- [x] improve main shot
    - it's too small
- [x] decide on a color palette with lizenn
- [x] get lizenn to design a player shot
- [x] teach lizenn git

## polish
- [ ] 2 frames turn animation for the ship
- [ ] animate flame for backward and forward motions (longer and shorter)

# implementation information
## conventions
### sprite positioning
`thing.spx` is the offset in pixel where to draw the sprite

### hitbox
the hitbox always starts at `thing.x` `thing.y`
the size is specified by `thing.xb` `thing.yb`

# visuals
## font
characters are `3x5` pixels

# ideas
- vertical hud

## explosions
- varied particles in size colors
- big center explosion ball that pops and shrinks ?
- [x] particles spawning smaller particles
- particles type based on their speed
- shockwave effect (circle)
### DOJ
- 2 phases
    - big yellow blasts (few)
    - after bigs depop multiple orange to yellow blasts
    - fades to grey

## hit effect
- small oval shape where the bullet hits and disappears
    - this is read as a shielding effect and actually could mean big enemies in doj shield the smaller side shots which could make sense
- color can be as bold as the shot itself
- enemies blink in a colored state, quite bold color again(blue in DOJ)
    - big enemies have fire sprites spawning on them
- x shape ?
- [x] I need to know the impact bullet enemy position to place properly my hit effect wrt to the bullet

## I just want a big laser shot mannnn
- hit effect for laser shot ==> becomes huge/concentrated(bright, even white) at the impact point


## since the bar is the same color as the enemy could we design a system where you go and collect sth on them ?

## moonshot (next game/out of scope)
### memorable character integration
- get a cool pilot view on screen that is animated and cool
- characters are grabbing us to games

# log
## 31/07/2025
- implem lizenn sprite
- use custom color palette
## 01/08/2025
- watch lazy shmup ep 15 better explosions
## 02/08/2025
- shot lag fixed
## 03/08/2025
- finish explosions + shockwave
## 04/08/2025
- give health to enemies
- wip hit effect
- have lizenn draw enemies (3 to 4, varied sizes)
- improve sfx
## 05/08/2025
- fix hitbox
- fix sprite draw positions
- fix and improve explosions
## 16/08/2025
- migrate code out of pico8
- study ui from lizenn
- take ui and palette decisions w/ Lizenn
- rework bullet system and improve it
- shmup tutorial ep17
- in ep14 palette trick to make flash hit impact
## 17/08/2025
- implement hit impact
- implement game flow
    - wave management
    - win screen
- [x] send pico8 to lizenn
- implement new palette
## 18/08/2025
- v1 laser
- fix hitboxes
## 19/08/2025
- laser update