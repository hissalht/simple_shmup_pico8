# todo
- [ ] vertical UI
    - [x] ui feedback : I feel health is not legible
    - remaining space on top of the bar for the rest of infos
        - score
        - wave counter
    - [x] implement ui prototype (functionnal)
    - [ ] implement ui skin
- [x] conceive enemy management system
    - first draft done
    - [ ] ease the spawn of a formation of enemy maybe ?
    - to be improved after enemies attacks
    - [ ] enemy types system
- [ ] enemy attacks
- [x] make enemy sprite shake when they get hit
- [ ] prevent enemies from dying off screen where I spawn them
- [x] fix diagonal movement of the ship
    - https://www.youtube.com/watch?v=oBjZ1W50brM&list=PLea8cjCua_P1o-xiQRf_QzqS2pMVlGnse&index=5


- [ ] laser improvements
    - [x] build up in size
    - [x] stop on enemies
    - [x] concentrated laser at origin
        - [x] and end
    - [x] particle effect to give movement to the chunk of the laser
        - did an animated moving sprite column
    - tested lizenn ring laser and spiral, doesnt work in our technical limits
    - [ ] particles/sprite at begining and end
- [ ] fix : hit impact stop animating on wave screen
- [ ] improve muzzle flash
    - see lizenn proposal, I can maybe program sth similar with a bunch of shrinking ovals
- [ ] manage ship states with a state machine
    - [ ] lock main shot when laser
    - [x] normalize diagonal ship speed

## probably not ?
- [ ] reduce ship speed when laser ??
    - may be incompatible with a meter/resource gated laser

## done
- [x] change hit impact
- [x] recheck hitbox matching
- [x] update ship sprite
- [x] laser meter system
- [x] introduce weapon damage
- [x] win screen
    - button lockout to avoid skipping it
- [x] quick fix collision between ship and border of screen
- [x] laser shot v1
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
- [ ] flame tweak ?
    - https://saint11.art/img/pixel-tutorials/RocketTrail.gif
- [ ] awkward flame on turns
- [ ] program particles for ship engine


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
- vertical hud DONE

## enemy system
- spawn 2 enemy type multiple time
- information for position idea from A.
    - give an array of offsets from 1 enemy to the next
- enemy type should contain
    - hp
    - attack type
    - movement speed

###
- one update function per enemy type for their shot and movement if necessary
- store speed in enemy type

### tracking shot concept
```lua
fire_prop.x_spawn = fire_prop.radius * cos(fire_prop.thet_bul)
fire_prop.y_spawn = fire_prop.radius * sin(fire_prop.thet_bul)

prop.thet_bul += prop.thet_speed
if prop.thet_bul >= 1 then
    prop.thet_speed *= -1
end
if prop.thet_bul <= 0.5 then
    prop.thet_speed *= -1
end
prop.x_spawn = prop.radius * cos(prop.thet_bul)
prop.y_spawn = prop.radius * sin(prop.thet_bul)
```

## explosions DONE
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

## hit effect DONE
- small oval shape where the bullet hits and disappears
    - this is read as a shielding effect and actually could mean big enemies in doj shield the smaller side shots which could make sense
- color can be as bold as the shot itself
- enemies blink in a colored state, quite bold color again(blue in DOJ)
    - big enemies have fire sprites spawning on them
- x shape ?
- [x] I need to know the impact bullet enemy position to place properly my hit effect wrt to the bullet

## I just want a big laser shot mannnn WIP
- hit effect for laser shot ==> becomes huge/concentrated(bright, even white) at the impact point


## since the bar is the same color as the enemy could we design a system where you go and collect sth on them ?

## moonshot (next game/out of scope)
### memorable character integration
- get a cool pilot view on screen that is animated and cool
- characters are grabbing us to games

# concepts
## easing function to smooth out movement (variable evolution)
- `x+=(x-target_x)/n`
    - some number n (2 is fast)
    - this does not attain the exact target
    - snap them in position when they get close !
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
## 21/08/2025
- laser height animation adjustment
- proto laser meter
- proto ui
## 22/08/2025
- shmup tutorial ep 18
    - enemy types
- shmup tutorial ep 19/20
    - skipped most of it cause already done or my enemies needs are more complex
- think about enemy design on paper
## 23/08/2025
- shmup tutorial ep 21 on enemy movement
## 26/08/2025
- still working on enemy spawn system
    - specify speed of enemy instead of arrival timer for moves
## 27/08/2205
- finish lerp implementation
## 07/09/2025
- enemy shake
- uncover movement problem with float speed (diagonal normalization !)
## 27/09/2025
## 28/09/2025
- fix diagonal cobblestoning problem and normalize diagonal ship speed
## 01/10/2025
- work on enemy system