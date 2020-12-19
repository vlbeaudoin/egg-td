# egg-td
Project for the [godot wild jam 28](https://itch.io/jam/godot-wild-jam-28)

## License
* Code is licensed under MIT. See `LICENSE` for details.
* Music (inside `music/`) is licensed under CC BY-SA 4.0, see https://creativecommons.org/licenses/by-sa/4.0/.
* Art assets: [please add attribution and details here]

## Towers zone
This place could be a tilemap of 32x32 quares. Walls can be built on this zone, and mobs (wolves, snakes, dogs, racoons, ...) will attempt to come steal the eggs by passing through here.

--⁃ 16x16 or 24x24 maybe? are we talking tile resolution here?
--⁃	but yeah, 32x32 seems like a good size for the play area, but might need to go smaller depending on how many tiles we can fit

A maze must be built in order to slow the progression of mobs.

--⁃	you have limited walls, but can move them and you can add new ones over time

Towers can be built on walls.



Chickens can "operate" towers to defend, or stay in the nestboxes in the pastures to augment production of eggs, and be able to afford new upgrades for the towers / chickens.

--⁃	great idea
--⁃	wondering if you get more chickens over time, and if some towers can operate autonomously, with less effectiveness of course

It is expected for the chickens to move around frequently in order to cater to the need of defending the pasture (by operating towers) and producing eggs (for upgrades, in nestboxes in the pasture zone).

## Controls
Probably pretty mouse-heavy, since chickens can be assigned to towers or nestboxes with the mouse, crafting would be using it, obtaining items, ..

However, I think keyboard shortcuts are great so I propose:

1-2-3-4-5-6-shift1-shift2-shift3-shift4-shift5-shift6 : select corresponding item in the storage (1 to 12).

Q: Add item to crafting list
E: Execute crafting (attempt recipe), then clear crafting list whether it succeeded or not.
R: Clear crafting list

--⁃	sure, but focus on mouse controls

## Crafting
One idea for using eggs would be to have mobs randomly drop blank equipment pieces / upgradeable artifacts, which you would be able to feed eggs to ("craft") and lock in stats for that equipment / artifact. You would then be able to equip and unequip the equipment / artifact at will, but not change the stats on it.

Example: You have 2 speed eggs, a power egg and a pierce egg.
A wolf dies, and drops a blank helmet (conveniently avian-sized).
The helmet ends up in the storage (somehow, not sure how yet (runner chicken / drag-and-drop / context menu / ...)).
The player hovers the mouse cursor over the helmet, presses the "add to crafting list" key, then does the same to all 4 eggs. 
There is a UI being updated on-screen showing the items in the crafting list (maybe set some outline or modulate on the items that were selected).
Once they are done, the player presses the "execute crafting" key, and the recipe is attempted. Valid recipes include things like |piece of equipment, egg, egg, ...|  (or other possible recipes, like merging eggs together to boost the potency of existing eggs or create new eggs, giving new effects to chicken attacks / egg production).
IF the recipe is valid, the selected items are cleared and the resulting item is added in the place of the first item selected. 
If it is an upgraded egg, in can be further upgraded or fed to an artifact to then be equiped on a chicken.

Does this make sense? lol. Anyway.

--⁃	should have the chickens in the nest generating new eggs
--⁃	and crafting is possible with only eggs, but augmented with artifacts
--⁃	otherwise great!


## Moving and assigning chickens
Chickens can be moved by dragging them, which could visually drag a shadow of the chicken to the destination the player wants to assign the chicken. After the shadow is dropped, the chicken will move towards the destination.

Note: it would be interesting that, as the chickens go from different points, they would be vulnerable to attacks of mobs if they cross their attack radius. Then, they would need to have high enough speed to reach the destination in time, or you would have one less chicken to operate your stuff with. That potential loss of workers could be a difficulty of the game in itself, to make sure you only send the chickens somewhere when it is safe. If that is the case, it'd be cool to be able to drop the chickens around to move them out of harm's way before dropping them where they do need to go. Not sure if I make sense?

--⁃	hmm, maybe you can make hidden paths for the chickens so they stay safe?
--⁃	if in doubt, just make the transfer no-risk

## Storage
There are 12 slots (4x3 grid in the pastures) available for storage of eggs and artifacts/equipment. The limited space is to force the player to quickly rotate their eggs by merging them or by feeding them into equipment, at the risk of losing eggs or equipment by not having enough space to store it.

--⁃	yep, sounds good

## Drops
Have item drops and chicken egg-laying to create new items on the world. The items can be interacted with (clicked) in order to attempt to add them to the storage, if space is available. If it stays on the ground for more than x seconds, it gets the queue_free() treatment.

--⁃	I wonder if the eggs in the nest should be added to your inventory automatically
--⁃	equipment at least can work just like you said

## Nestboxes
There are a few nest boxes set up in the pastures, and that is where chickens go if they are not affected to a tower. There, they will feed in the pastures and lay eggs (egg laying speed and potency of eggs can be increased with equipment/artifacts equiped on chickens). Eggs are added to the storage by clicking on them, 

--⁃	maybe common eggs don't even take up space in the inventory, only special eggs do?
