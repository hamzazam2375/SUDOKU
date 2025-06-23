[org 0x0100]

jmp start 

;============================== GLOBAL VARIABLES ==============================;	 

score: dw 0
mistakes: db 0
notes: db 0
min: dw 0
sec: dw 0
tickCount: db 0
offTimer: db 0
oldisrForTime: dd 0
oldisrForKey: dd 0
notes_str: db ' NOTES: '
notes_on: db ' ON '
notes_off: db ' OFF '
undo: db ' UNDO: Press U '
colon: db ' : '
bufferForFirstBoard: times 2000 dw '0'
bufferForSecondBoard: times 2000 dw '0'
secondBoardSaved: dw 0
dummy: dw 0
dummy1: dw 0
change_background: db 0
save_num : times 15 dw '0'
next_loc_num : times 12 dw 0
save_box_no: times 81 dw 0
levels: db 0
screen_flag : dw 0
red_print: db 0
game_won : db'!!!!!!GAME WON!!!!!!'
game_loss: db'!!!!!GAME LOST!!!!!'
justEnd: db 1
no_inc_nc: times 81 dw  0
produceSound: db 0

;============================== ENTERIES ==============================;	 
			 
keysEasyLvl: dw 2, 5, 7, 4, 6, 9, 8, 1, 3,
			 dw	9, 8, 4, 3, 5, 1, 6, 2, 7,
			 dw	6, 1, 3, 2, 8, 7, 5, 9, 4,
			 dw 8, 3, 2, 9, 4, 6, 1, 7, 5,
			 dw	7, 4, 5, 1, 2, 8, 3, 6, 9,
			 dw	1, 9, 6, 5, 7, 3, 2, 4, 8,
			 dw 3, 7, 8, 6, 9, 2, 4, 5, 1,
			 dw	4, 2, 9, 8, 1, 5, 7, 3, 6,
			 dw	5, 6, 1, 7, 3, 4, 9, 8, 2
			 
keysMediumLvl: dw 2, 6, 9, 3, 7, 8, 1, 4, 5,
			 dw	5, 8, 1, 4, 2, 9, 6, 7, 3,
			 dw	4, 7, 3, 5, 6, 1, 2, 9, 8,
			 dw 6, 9, 4, 8, 3, 2, 5, 1, 7,
			 dw	8, 1, 2, 7, 4, 5, 9, 3, 6,
			 dw	3, 5, 7, 1, 9, 6, 8, 2, 4,
			 dw 1, 3, 5, 9, 8, 4, 7, 6, 2,
			 dw	7, 2, 8, 6, 1, 3, 4, 5, 9,
			 dw	9, 4, 6, 2, 5, 7, 3, 8, 1
			 
keysHardLvl: dw 9, 7, 4, 3, 1, 2, 6, 5, 8,
			 dw	2, 6, 1, 9, 5, 8, 7, 4, 3,
			 dw	8, 3, 5, 6, 7, 4, 2, 9, 1,
			 dw 3, 1, 9, 2, 4, 7, 5, 8, 6,
			 dw	7, 8, 6, 1, 9, 5, 3, 2, 4,
			 dw	4, 5, 2, 8, 6, 3, 1, 7, 9,
			 dw 6, 2, 7, 4, 3, 9, 8, 1, 5,
			 dw	5, 4, 3, 7, 8, 1, 9, 6, 2,
			 dw	1, 9, 8, 5, 2, 6, 4, 3, 7
			 
dummyKeys1: times 81 dw 0
dummyKeys2: times 81 dw 0
dummyKeys3: times 81 dw 0

dummyKeys12: dw 0, 1, 1, 1, 1, 1, 1, 0, 1,
			dw	1, 1, 1, 1, 1, 1, 1, 1, 1,
			dw	1, 1, 1, 1, 1, 1, 1, 1, 1,
			dw 1, 1, 1, 1, 0, 1, 1, 1, 1,
			dw	1, 1, 1, 1, 1, 1, 1, 1, 1,
			dw	1, 1, 1, 1, 1, 1, 1, 1, 1,
			dw 1, 1, 1, 1, 1, 1, 1, 1, 1,
			dw	1, 1, 1, 1, 1, 1, 1, 1, 1,
			dw	1, 1, 1, 1, 1, 1, 1, 1, 0
			
dummyKeys22: dw 0, 1, 0, 1, 0, 1, 1, 0, 0,
			dw	1, 1, 1, 0, 0, 1, 1, 0, 0,
			dw	0, 0, 1, 1, 0, 0, 0, 0, 0,
			dw 0, 1, 0, 1, 0, 1, 0, 0, 0,
			dw	0, 0, 0, 1, 1, 1, 1, 1, 1,
			dw	1, 1, 0, 0, 0, 1, 1, 0, 1,
			dw 1, 1, 1, 0, 0, 0, 0, 0, 0,
			dw	1, 0, 1, 1, 1, 1, 1, 0, 0,
			dw	1, 1, 0, 0, 0, 1, 1, 0, 0
			
dummyKeys32: dw 0, 1, 0, 1, 0, 1, 0, 0, 1,
			dw	1, 0, 1, 0, 1, 0, 0, 0, 1,
			dw	1, 0, 0, 0, 1, 0, 0, 0, 0,
			dw 1, 0, 0, 1, 0, 0, 0, 1, 0,
			dw	0, 0, 1, 0, 0, 0, 1, 0, 0,
			dw	1, 1, 0, 1, 0, 1, 0, 0, 1,
			dw 1, 0, 1, 0, 0, 1, 0, 1, 1,
			dw	0, 1, 0, 0, 0, 0, 0, 0, 0,
			dw	0, 1, 1, 1, 1, 0, 0, 0, 0

;============================== FOR HANDLING ENTERIES ==============================;

cursorXpos: dw 4, 10, 16, 25, 31, 37, 46, 52, 58
cursorYpos: dw 1, 5, 9, 13, 17, 21
cursorYposForBoard2: dw 1, 5, 9
Xcurrent: dw 0 
Ycurrent: dw 0
YcurrentForBoard2: dw 0
Xprevious: dw 0
Yprevious dw 0
YpreviousForBoard2: dw 0
boxNo: dw 0
game_completed: db 0
filledBoxes: times 81 dw 0

;============================== FOR STARTING SCREEN ==============================;

borders: dw 162, 316, 318, 320, 322, 476, 478, 480, 482, 636, 638, 640, 642, 796, 798, 800, 802, 956, 958, 960, 962, 1116, 1118, 1120, 1122, 1276, 1278, 1280, 1282, 1436, 1438, 1440, 1442, 1596, 1598, 1600, 1602, 1756, 1758, 1760, 1762, 1916, 1918, 1920, 1922, 2076, 2078, 2080, 2082, 2236, 2238, 2240, 2242, 2396, 2398, 2400, 2402, 2556, 2558, 2560, 2562, 2716, 2718, 2720, 2722, 2876, 2878, 2880, 2882, 3036, 3038, 3040, 3042, 3196, 3198, 3200, 3202, 3356, 3358, 3360, 3362, 3516, 3518, 3520, 3522, 3676, 3678, 3680, 3682, 3836, 3838
line1: dw 21, 6, 38, 0x3020, 0x3020, 0x3020, 0x3020, 7020h, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020, 7020h, 7020h, 0x3020, 0x3020, 0x3020, 0x3020, 7020h, 7020h, 7020h,  0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 7020h, 7020h, 0x3020, 7020h, 7020h, 0x3020, 7020h, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020
line2: dw 21, 7, 38, 0x3020, 7020h, 7020h, 7020h, 7020h, 7020h, 0x3020,  7020h, 7020h, 7020h, 0x3020,  7020h, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020,  7020h, 7020h, 0x3020,  7020h, 7020h, 7020h, 0x3020,  7020h, 7020h, 0x3020, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020
line3: dw 21, 8, 38, 0x3020, 0x3020, 0x3020, 0x3020, 7020h, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020, 7020h, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020, 7020h, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020, 7020h, 7020h, 0x3020, 0x3020, 7020h, 7020h, 7020h, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020
line4: dw 21, 9, 38, 7020h, 7020h, 7020h, 0x3020, 7020h, 7020h, 0x3020,  7020h, 7020h, 7020h, 0x3020,  7020h, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020,  7020h, 7020h, 0x3020,  7020h, 7020h, 7020h, 0x3020,  7020h, 7020h, 0x3020, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020, 7020h, 7020h, 7020h, 0x3020
line5: dw 21, 10, 38, 0x3020, 0x3020, 0x3020, 0x3020, 7020h, 7020h, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 7020h, 7020h, 0x3020, 0x3020, 0x3020, 0x3020, 7020h, 7020h, 7020h,  0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 7020h, 7020h, 0x3020, 7020h, 7020h, 0x3020, 7020h, 7020h, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
new_game1: dw 35, 14, 10, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
new_game: db ' NEW GAME '
new_game3: dw 35, 16, 10, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
end_game1: dw 35, 18, 10, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
end_game: db ' END GAME '
end_game3: dw 35, 20, 10, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
flag1: db 0

;============================== FOR LEVELS SCREEN ==============================;
message: db 'S E L E C T  L E V E L'
length1 : dw 22
message1: db '   EASY'
length2 : dw 7
message2: db '   INTERMEDIATE'
length3 : dw 15
message3: db '   HARD'
length4 : dw 7

flag2: db 0
choose_levels: db ' CHOOSE LEVELS: '
levels_screen1: dw 31, 6, 16, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
levels_screen2: dw 31, 8, 16, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020

easy: db ' EASY '
easy1: dw 37, 10, 6, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
easy2: dw 37, 12, 6, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
medium: db ' INTERMEDIATE '
medium1: dw 36, 14, 8, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
medium2: dw 36, 16, 8, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
hard: db ' HARD '
hard1: dw 37, 18, 6, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
hard2: dw 37, 20, 6, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020

;============================== FOR ENDING SCREEN ==============================;

end_screen1: dw 22, 4, 36, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
end_screen2: dw 22, 5, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen3: dw 22, 6, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen4: dw 22, 7, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen5: dw 22, 8, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen6: dw 22, 9, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen7: dw 22, 10, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen8: dw 22, 11, 36, 0x3020, 0x7020, 0x7020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x7020, 0x7020, 0x3020
end_screen9: dw 22, 12, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen10: dw 22, 13, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen11: dw 22, 14, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen12: dw 22, 15, 36, 0x3020, 0x7020, 0x7020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3F2F, 0x3F33, 0x3020, 0x7020, 0x7020, 0x3020
end_screen13: dw 22, 16, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen14: dw 22, 17, 36, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020
end_screen15: dw 22, 18, 36, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020, 0x3020
game_over: db ' !!! GAME OVER !!! '
score_str: db ' SCORE:      '
Difficulty_str: db ' DIFFICULTY: '
time_str: db ' Time        '
mistakes_str: db ' MISTAKES:   '
mistakes_str1: db ' MISTAKES:  /3'
Null: db '     ---     '

;============================== UNDO STACK ==============================;

di_location: times 100 dw 0
enter_num1: times 100 db 0 
index1: dw 0
notes_nf:  times 100 db 0
box_call: times 200 dw 0

;============================== FOR BOARD ==============================;

board1: times 65 dw 0x3020
board2: dw 0x3020, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x737C, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x737C, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020, 0x3020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x737C, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x737C, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020, 0x3020,  0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x737C, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x737C, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x7020, 0x3020, 0x3020, 
board3: dw 0x3020, 0x3020, 0x7020, 0x732D, 0x732D, 0x732D, 0x732D, 0x732D, 0x737C, 0x732D, 0x732D, 0x732D, 0x732D, 0x732D, 0x737C, 0x732D, 0x732D, 0x732D, 0x732D, 0x732D, 0x7020, 0x3020, 0x3020, 0x7020, 0x732D, 0x732D, 0x732D, 0x732D, 0x732D, 0x737C, 0x732D, 0x732D, 0x732D, 0x732D, 0x732D, 0x737C, 0x732D, 0x732D, 0x732D, 0x732D, 0x732D, 0x7020, 0x3020, 0x3020, 0x7020, 0x732D, 0x732D, 0x732D, 0x732D, 0x732D, 0x737C, 0x732D, 0x732D, 0x732D, 0x732D, 0x732D, 0x737C, 0x732D, 0x732D, 0x732D, 0x732D, 0x732D, 0x7020, 0x3020, 0x3020
board4: times 15 dw 0x792D
mess1: db '|'
mess2: db '-'

;============================== Numbers Card ==============================;

num1: db '1','2','3','4','5','6','7','8','9'
num2: db '0','0','0','0','0','0','0','3','0'
cardFreq1: db '1','2','0','1','0','0','0','0','0'
cardFreq2: db '5','8','2','5','4','4','6','4','5'
cardFreq3: db '7','5','4','7','5','7','6','4','6'

print_str1:
	push bp
	mov bp,sp
	push es
	push ax
	push cx
	push bx
	push di
	push dx
	
	mov dx,0
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+10]
	add ax,[bp+12]
	shl ax,1
	mov bx,[bp+6]
	mov di,ax
	mov dl,[bx+si]
	mov cx,[bp+4]
	mov ah,[bp+8]
	nextchar9:
	mov al,dl
	mov [es:di],ax
	add di,2
	loop nextchar9
	
	pop dx
	pop di
	pop bx
	pop cx
	pop ax
	pop es
	pop bp
	ret 10
;============================== RELOADING ==============================;

reloadUndo:
	push ax
	push bx
	push cx
	push si
	
	mov cx, 15
	mov bx, save_num
	xor si, si
reloadLoop1:
	mov word [bx+si], '0'
	add si, 2
	loop reloadLoop1
	mov cx, 12
	mov bx, next_loc_num
	xor si, si
reloadLoop2:
	mov word [bx+si], 0
	add si, 2
	loop reloadLoop2
	mov cx, 81
	mov bx, save_box_no
	xor si, si
reloadLoop3:
	mov word [bx+si], 0
	add si, 2
	loop reloadLoop3
	mov cx, 100
	mov bx, di_location
	xor si, si
reloadLoop5:
	mov word [bx+si], 0
	add si, 2
	loop reloadLoop5
	mov cx, 100
	mov bx, enter_num1
	xor si, si
reloadLoop6:
	mov word [bx+si], 0
	add si, 1
	loop reloadLoop6
	mov cx, 100
	mov bx, notes_nf
	xor si, si
reloadLoop7:
	mov word [bx+si], 0
	add si, 1
	loop reloadLoop7
	mov cx, 200
	mov bx, box_call
	xor si, si
reloadLoop8:
	mov word [bx+si], 0
	add si, 2
	loop reloadLoop8
	mov word [index1], 0
	pop si
	pop cx
	pop bx
	pop ax
	ret
	
reloadDummys:
	push bp
	mov bp, sp
	push ax
	push bx
	push si
	push cx
	
	mov bx, [bp+4]
	mov si, [bp+6]
	mov cx, 81
reloadLoop4:
	mov ax, [bx]
	mov [si], ax
	add bx, 2
	add si, 2
	loop reloadLoop4	
	pop cx
	pop si
	pop bx
	pop ax
	pop bp
	ret 4
	
loadFreq:
	push bp
	mov bp, sp
	push ax
	push bx
	push si
	push di
	push es
	push ds
	mov si, 0
freqLoop:
	mov bx, [bp+4]
	add bx, si
	mov al, [bx]
	mov byte [num2+si], al
	add si, 1
	cmp si, 9
	jne freqLoop
	pop ds
	pop es
	pop di
	pop si
	pop bx
	pop ax
	pop bp
	ret 2
   
;============================== SOUND ==============================;
   
track: dw 3000, 4000, 5000, 4000, 3000 ; THIS IS THE TRACK FREQUENCY ARRAY
track_d: dw 4, 5, 6, 5, 4              ; THIS IS THE TRACK DELAY ARRAY
track_s: dw 5  
track1: dw 3000, 2000, 4000 ; THIS IS THE TRACK FREQUENCY ARRAY
track_d1: dw 4, 6, 5              ; THIS IS THE TRACK DELAY ARRAY
track_s1: dw 3 
track2: dw 5000, 3000, 4000 ; THIS IS THE TRACK FREQUENCY ARRAY
track_d2: dw 7, 4, 7              ; THIS IS THE TRACK DELAY ARRAY
track_s2: dw 3

DELAY:  ;delay of 1/18.2 seconds
    push bp
    mov bp, sp
    push cx
    push ax
DF_l1:                             
    cmp word[bp+4], 0
    je DF_end
    mov ax, 0x0001
DF_l2:
    mov cx, 0xFFFF
DS_l3:
	loop DS_l3     
    dec ax
    jnz DF_l2
    dec word[bp+4]
    jmp DF_l1
DF_end:
    pop ax
    pop cx
    pop bp
    ret 2
sound:
    PUSH BP
    MOV BP, SP
    PUSHA
    mov ax, [bp + 6]
    out 42h, al
    mov al, ah
    out 42h, al

    in al, 61h
    mov ah ,al
    or al, 3h
    out 61h, al
    mov bx, 5
    mov bx,[bp+4]
    push bx
    call DELAY    
    mov al, ah
    out 61h, al
    POPA
    POP BP
	ret 4
play_track:
	push bp
	mov bp, sp
	push ax
	push cx
	push si
	push di
	mov word cx, [bp + 4]
	mov si, [bp + 6]
	mov di, [bp + 8]
track_loop:
    push word [di]
    push word [si]
    call sound
    add si, 2
    add di, 2
	loop track_loop
	pop di
	pop si
	pop cx
	pop ax
	pop bp
	ret 6
	
;============================== CHECK IF ROW OR COLUMN OR GAME COMPLETED ==============================;

checkIfGameIsCompleted:
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push si	
	mov cx, 0
loopp:
	mov bx, [bp+4]
	add bx, cx
	cmp word [bx], 0
	je exitCheck
	add cx, 2
	cmp cx, 162
	jne loopp
	mov byte [game_completed], 1
    jmp ending_screen
exitCheck:	
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 2
	
checkIfRowIsCompleted:
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push es
	push si
	mov cx, [boxNo]
	mov si, [bp+4]
	mov ax, [Xcurrent]
	add si, cx
	cmp ax, 0
	je forwardChecking
backWardChecking:
	cmp word [si], 0
	je return
	sub si, 2
	sub ax, 2
	cmp ax, 0
	jne backWardChecking
	mov cx, [boxNo]
	mov si, [bp+4]
	mov ax, [Xcurrent]
	add si, cx
forwardChecking:
	cmp word [si], 0
	je return
	add si, 2
	add ax, 2
	cmp ax, 18
	jne forwardChecking	
	mov byte [produceSound], 1
return:
	pop si
	pop es
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 2
	
checkIfColIsCompleted:
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push si
	mov cx, [boxNo]
	mov si, [bp+4]
	mov ax, [Ycurrent]
	add si, cx
	cmp ax, 0
	je forwardChecking1
backWardChecking1:
	cmp word [si], 0
	je return1
	sub si, 18
	sub ax, 2
	cmp ax, 0
	jne backWardChecking1
	mov cx, [boxNo]
	mov si, [bp+4]
	mov ax, [Ycurrent]
	add si, cx
	cmp ax, 16
	je return1
forwardChecking1:
	cmp word [si], 0
	je return1
	add si, 18
	add ax, 2
	cmp ax, 16
	jne forwardChecking1	
	mov byte [produceSound], 1
return1:
	pop si
	pop dx
	pop cx
	pop bx
	pop ax     
	pop bp
	ret 2

;============================== FOR PRINT NUMBERS ==============================;

print_1:
	push bp
	mov bp,sp
	push es
	push di
	push dx
	push cx
	push bx
	mov dx,0x785f
	mov cx,0x787c
	mov dh,byte[bp+4]
	mov ch,byte[bp+4]
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+6]
	add ax,[bp+8]
	shl ax,1
	mov di,ax
	add di, 160
	mov bh,[bp+4]
	mov bl,0x2f
	mov word[es:di],bx
	add di,2
	mov word[es:di],cx
	add di, 160
	mov word[es:di],cx
	sub di, 2
	mov word[es:di],dx
	add di, 4
	mov word[es:di],dx
	pop bx
	pop cx
	pop dx
	pop di
	pop es
	pop bp
	ret 6

print_2:
	push bp
	mov bp,sp
	push es
	push di
	push dx
	push cx
	mov dx,0x785f
	mov cx,0x787c
	mov dh,byte[bp+4]
	mov ch,byte[bp+4]
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+6]
	add ax,[bp+8]
	shl ax,1
	mov di,ax
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	add di,2
	add di, 160
	mov word[es:di],cx
	sub di,2
	mov word[es:di],dx
	sub di, 2
	mov word[es:di],dx
	add di, 160
	sub di, 2
	mov word[es:di],cx
	add di, 2
	mov word[es:di],dx
	add di, 2
	mov word[es:di],dx
	pop cx
	pop dx
	pop di
	pop es
	pop bp
	ret 6

print_3:
	push bp
	mov bp,sp
	push es
	push di
	push dx
	push cx
	mov dx,0x785f
	mov cx,0x787c
	mov dh,byte[bp+4]
	mov ch,byte[bp+4]
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+6]
	add ax,[bp+8]
	shl ax,1
	mov di,ax
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	add di,2
	add di, 160
	mov word[es:di],cx
	sub di,2
	mov word[es:di],dx
	sub di, 2
	mov word[es:di],dx
	add di, 160
	mov word[es:di],dx
	add di, 2
	mov word[es:di],dx
	add di, 2
	mov word[es:di],cx
	pop cx
	pop dx
	pop di
	pop es
	pop bp
	ret 6

print_4:
	push bp
	mov bp,sp
	push es
	push di
	push dx
	push cx
	mov dx,0x785f
	mov cx,0x787c
	mov dh,byte[bp+4]
	mov ch,byte[bp+4]
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+6]
	add ax,[bp+8]
	shl ax,1
	mov di,ax
	add di, 160
	sub di, 2
	mov word[es:di],cx
	add di,2
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	add di,2
	mov word[es:di],cx
	add di,160
	mov word[es:di],cx
	pop cx
	pop dx
	pop di
	pop es
	pop bp
	ret 6

print_5:
	push bp
	mov bp,sp
	push es
	push di
	push dx
	push cx
	mov dx,0x785f
	mov cx,0x787c
	mov dh,byte[bp+4]
	mov ch,byte[bp+4]
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+6]
	add ax,[bp+8]
	shl ax,1
	mov di,ax
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	sub di,4
	add di,160
	mov word[es:di],cx
	add di,2
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	add di,2
	add di,160
	mov word[es:di],cx
	sub di,2
	mov word[es:di],dx
	sub di,2
	mov word[es:di],dx
	pop cx
	pop dx
	pop di
	pop es
	pop bp
	ret 6

print_6:
	push bp
	mov bp,sp
	push es
	push di
	push dx
	push cx
	mov dx,0x785f
	mov cx,0x787c
	mov dh,byte[bp+4]
	mov ch,byte[bp+4]
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+6]
	add ax,[bp+8]
	shl ax,1
	mov di,ax
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	sub di,4
	add di,160
	mov word[es:di],cx
	add di,2
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	add di,2
	add di,160
	mov word[es:di],CX
	sub di,6
	mov word[es:di],CX
	add di,2
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	pop cx
	pop dx
	pop di
	pop es
	pop bp
	ret 6

print_7:
	push bp
	mov bp,sp
	push es
	push di
	push dx
	push cx
	mov dx,0x785f
	mov cx,0x787c
	mov dh,byte[bp+4]
	mov ch,byte[bp+4]
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+6]
	add ax,[bp+8]
	shl ax,1
	mov di,ax
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	add di,2
	add di,160
	mov word[es:di],CX
	add di,160
	mov word[es:di],CX
	pop cx
	pop dx
	pop di
	pop es
	pop bp
	ret 6

print_8:
	push bp
	mov bp,sp
	push es
	push di
	push dx
	push cx
	mov dx,0x785f
	mov cx,0x787c
	mov dh,byte[bp+4]
	mov ch,byte[bp+4]
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+6]
	add ax,[bp+8]
	shl ax,1
	mov di,ax
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	add di,2
	add di,160
	mov word[es:di],cx
	sub di,160
	sub di,6
	add di,160
	mov word[es:di],cx
	add di,160
	mov word[es:di],cx
	sub di,160
	add di,2
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	add di,2
	add di,160
	mov word[es:di],cx
	sub di,2
	mov word[es:di],dx
	sub di,2
	mov word[es:di],dx
	pop cx
	pop dx
	pop di
	pop es
	pop bp
	ret 6

print_9:
	push bp
	mov bp,sp
	push es
	push di
	push dx
	push cx
	mov dx,0x785f
	mov cx,0x787c
	mov dh,byte[bp+4]
	mov ch,byte[bp+4]
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+6]
	add ax,[bp+8]
	shl ax,1
	mov di,ax
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	add di,2
	add di,160
	mov word[es:di],cx
	sub di,160
	sub di,6
	add di,160
	mov word[es:di],cx
	add di,2
	mov word[es:di],dx
	add di,2
	mov word[es:di],dx
	add di,2
	add di,160
	mov word[es:di],cx
	sub di,2
	mov word[es:di],dx
	sub di,2
	mov word[es:di],dx
	pop cx
	pop dx
	pop di
	pop es
	pop bp
	ret 6

;============================== EXTRACT AND PRINT RANDOM VALUES ==============================;

moveRandom:
	push bp
	mov bp, sp
	push si
	push bx
	push dx
	push di
	
	mov si, [bp+6]
	mov di, [bp+4]
	mov bx, 0
nextIteration:	
	mov dx, [si+bx]
	cmp word [di+bx], 0
	je skipKey
	mov [di+bx], dx
skipKey:
	add bx, 2
	cmp bx, 162
	jne nextIteration
	
	pop di
	pop dx
	pop bx
	pop si
	pop bp
	ret 4
	
printRandom:
	push bp
	mov bp, sp
	push ax
	push es
	push bx
	push cx
	push dx
	push si
	push di
	
	mov ax, 0xb800
	mov es, ax
	mov cx, 0
nextIteration1:
	mov bx, cursorXpos
	add bx, [Xcurrent]
	mov si, cursorYpos
	add si, [Ycurrent]
	push word [bx]
	push word [si]
	push 0x70
	mov bx, [bp+2]
	add bx, cx
	mov si, [bx]
	cmp si, 1
	je CallPrint1
	cmp si, 2
	je CallPrint2
	cmp si, 3
	je CallPrint3
	cmp si, 4
	je CallPrint4
	cmp si, 5
	je CallPrint5
	cmp si, 6
	je CallPrint6
	cmp si, 7
	je CallPrint7
	cmp si, 8
	je CallPrint8
	cmp si, 9
	je CallPrint9
	jmp nextCall
CallPrint1:
	call print_1
	jmp nextCall
CallPrint2:
	call print_2
	jmp nextCall
CallPrint3:
	call print_3
	jmp nextCall
CallPrint4:
	call print_4
	jmp nextCall
CallPrint5:
	call print_5
	jmp nextCall
CallPrint6:
	call print_6
	jmp nextCall
CallPrint7:
	call print_7
	jmp nextCall
CallPrint8:
	call print_8
	jmp nextCall
CallPrint9:
	call print_9
nextCall:
	cmp word [Xcurrent], 16
	jne incrementX
	add word [Ycurrent], 2
	mov word [Xcurrent], 0
	add cx, 2
	cmp cx, 106
	jbe nextIteration1
incrementX:
	add word [Xcurrent], 2
	add cx, 2
	cmp cx, 106
	jbe nextIteration1
	
	mov word [Xcurrent], 0
	mov word [Ycurrent], 0
	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop es
	pop ax
	pop bp
	call highlightBox
	jmp wait_for_key22
	
printRandom1:
	push bp
	mov bp, sp
	push ax
	push es
	push bx
	push cx
	push dx
	push si
	push di
	
	mov ax, 0xb800
	mov es, ax
	mov cx, 108
	mov word [Xcurrent], 0
	mov word [YcurrentForBoard2], 0
nextIteration11:
	mov bx, cursorXpos
	add bx, [Xcurrent]
	mov si, cursorYposForBoard2
	add si, [YcurrentForBoard2]
	push word [bx]
	push word [si]
	push 0x70
	mov bx, [bp+2]
	add bx, cx
	mov si, [bx]
	cmp si, 1
	je CallPrint11
	cmp si, 2
	je CallPrint21
	cmp si, 3
	je CallPrint31
	cmp si, 4
	je CallPrint41
	cmp si, 5
	je CallPrint51
	cmp si, 6
	je CallPrint61
	cmp si, 7
	je CallPrint71
	cmp si, 8
	je CallPrint81
	cmp si, 9
	je CallPrint91
	jmp nextCall1
CallPrint11:
	call print_1
	jmp nextCall1
CallPrint21:
	call print_2
	jmp nextCall1
CallPrint31:
	call print_3
	jmp nextCall1
CallPrint41:
	call print_4
	jmp nextCall1
CallPrint51:
	call print_5
	jmp nextCall1
CallPrint61:
	call print_6
	jmp nextCall1
CallPrint71:
	call print_7
	jmp nextCall1
CallPrint81:
	call print_8
	jmp nextCall1
CallPrint91:
	call print_9
nextCall1:
	cmp word [Xcurrent], 16
	jne incrementX1
	add word [YcurrentForBoard2], 2
	mov word [Xcurrent], 0
	add cx, 2
	cmp cx, 160
	jbe nextIteration11
incrementX1:
	add word [Xcurrent], 2
	add cx, 2
	cmp cx, 160
	jbe nextIteration11
	
	push word [dummy1]
	pop word [Xcurrent]
	mov word [YcurrentForBoard2], 0
	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop es
	pop ax
	pop bp
	call highlightBox2
	jmp wait_for_key222

;============================== PRINTING NOTES (ON / OFF) ==============================;

print_notes:
	
	mov al, [notes]
	cmp al, 1
	je print_on
	
	mov ax, 74
    push ax
    mov ax, 18
    push ax
    mov ax, 0x79
    push ax
    mov ax, notes_off
    push ax
    push 5
    call print_str
	jmp endFunc
	
print_on:
	mov ax, 74
    push ax
    mov ax, 18
    push ax
    mov ax, 0x7e
    push ax
    mov ax, notes_on
    push ax
    push 4
    call print_str
endFunc:
	ret

;============================== TIME DELAYING ==============================;

time_delay:
    push cx            ; Save the value of CX on the stack
    mov cx, 0xFFFF     ; Load CX with the delay value (you can adjust this for more/less delay)
delay_loop:
    loop delay_loop    ; Decrement CX, and if CX is not zero, loop again
    mov cx, 0xFFFF     ; Load CX with the delay value (you can adjust this for more/less delay)
delay_loop2:
    loop delay_loop2 
	mov cx, 0xFFFF     ; Load CX with the delay value (you can adjust this for more/less delay)
delay_loop3:
    loop delay_loop3
    pop cx             ; Restore the value of CX from the stack
    ret                ; Return from the delay function
	
;============================== FOR PRINTING LEVELS ==============================;

print_mode:
	push bp
	mov bp, sp
	push ax
	mov ax, [bp + 8]
	push ax
	mov ax, [bp + 6]
	push ax
	mov ax, [bp + 4]
	push ax
	
	cmp byte [flag1], 1
	je skipp1
	cmp byte [flag2], 0
	je skipp2
	cmp byte [flag2], 1
	je skipp3
	cmp byte [flag2], 2
	je skipp4

skipp1:
	mov ax, Null
	push ax
	push 13
	jmp skipp
skipp2:
	mov ax, easy
	push ax
	push 6
	jmp skipp
skipp3:
	mov ax, medium
	push ax
	push 13
	jmp skipp
skipp4:
	mov ax, hard
	push ax
	push 6
	jmp skipp
skipp:
	call print_str
	
	pop ax
	pop bp
	
	ret 6
	;============================== FOR CLEARING SCREEN ==============================;

clear_screen:
	push es
	push ax
	push cx
	push di
	
	mov ax, 0xb800
	mov es, ax
	xor di, di
	mov ax, 0x7020
	mov cx, 2000

	cld
	rep stosw
	
	pop di
	pop cx
	pop ax
	pop es
	ret
	
;============================== SAVING FIRST BOARD ==============================;

scrollup:
	push di
	push si
	push ds
	push es
	mov ax, ds
	mov es, ax
	mov ax, 0xb800
	mov ds, ax
	mov si, 0
	mov di, bufferForFirstBoard
	mov cx, 2000
	cld
	rep movsw
	pop es
	pop ds
	pop si
	pop di
	ret
	
;============================== SAVING SECOND BOARD ==============================;

scrollDown:
	push di
	push si
	push ds
	push es
	mov ax, ds
	mov es, ax
	mov ax, 0xb800
	mov ds, ax
	mov si, 0
	mov di, bufferForSecondBoard
	mov cx, 2000
	cld
	rep movsw
	mov word [secondBoardSaved], 1
	pop es
	pop ds
	pop si
	pop di
	ret
 
;============================== PRINTING TIMER ==============================;

timer:
	push ax
	inc byte [tickCount]
	cmp byte [tickCount], 18
	jne exit
	mov byte [tickCount], 0
	inc word [sec]
	cmp word [sec], 60
	jne printTime
incMin:
	mov ax, 0xb800
	mov es, ax
	mov word [es:2396], 0x7020
	mov word [sec], 0
	inc word [min]
printTime:
	cmp byte [offTimer], 1
	je exit
	mov ax, 72
	push ax
	mov ax, 14
	push ax
	mov ax, [min]
	push ax
	mov ax, 0x79
	push ax
	call print_num
	
	mov ax, 74
	push ax
	mov ax, 14
	push ax
	mov ax, 0x79
	push ax
	mov ax, colon
	push ax
	push 3
	call print_str
	
	mov ax, 77
	push ax
	mov ax, 14
	push ax
	mov ax, [sec]
	push ax
	mov ax, 0x79
	push ax
	call print_num

exit:
	mov al, 0x20
	out 0x20, al
	
	pop ax
	iret

hookTimer:
	xor ax, ax
	mov es, ax
	
	mov ax, [es:8*4]
	mov [oldisrForTime], ax
	mov ax, [es:8*4+2]
	mov [oldisrForTime+2], ax
	
	cli 
	mov word [es:8*4], timer
	mov [es:8*4+2], cs
	sti
	
	ret
	
unhookTimer:
	push ax
	push es
	xor ax, ax
	mov es, ax
	mov ax, [oldisrForTime]
	mov word [es:8*4], ax
	mov ax, [oldisrForTime+2]
	mov word [es:8*4+2], ax
	pop es
	pop ax
	ret
	
unhookKey:
	push ax
	push es
	xor ax, ax
	mov es, ax
	mov ax, [oldisrForKey]
	mov word [es:9*4], ax
	mov ax, [oldisrForKey+2]
	mov word [es:9*4+2], ax
	pop es
	pop ax
	ret
 
;============================== PRINTING BORDERS FOR BACKGROUND FRAME ==============================;

printborder:
    mov ax, 0x3020        ; Border color and space (0x07 = white on black, 0x20 = space)
    ret

background_frame:
    push es
    push ax
	push cx
    push di
	push si
    
    mov ax, 0xb800        ; Video memory segment
    mov es, ax
    xor di, di            ; Start at top-left corner
	mov si, borders
nextloc:
    ; Check if it's in the first or last row (0-79 for top row, 1920-1999 for bottom row)
    cmp di, 160           ; 160 bytes (80 characters) in a row (2 bytes per character)
    jbe printborder_fill   ; If less than 160, it's the top border
check_border:
	cmp [si], di
	je print_side_border
    cmp di, 3840          ; 3840 = 80 * 24 * 2 (start of the last row)
    jb normal_fill        ; If less than 3840, it's the middle section
    cmp di, 4000          ; 4000 = 80 * 25 * 2 (end of the screen)
    jb printborder_fill   ; If less than 4000, it's the bottom border
normal_fill:
    mov ax, 0x7020        ; AX = 0x7820
    jmp fill_screen       ; Jump to common fill section
print_side_border:
	add si, 2
printborder_fill:
    call printborder      ; Border (white on black, space character)
fill_screen:
    mov word [es:di], ax  ; Write the word to video memory (both char and attribute)
    add di, 2             ; Move to the next character position
    cmp di, 4000          ; Check if we reached the end of the screen (80x25 characters)
    jne nextloc           ; Repeat until the whole screen is filled
	pop si
    pop di
	pop cx
    pop ax
    pop es
    
    ret                   ; Return to the caller
	
;============================== FOR PRINTING ROWS ONE BY ONE ==============================;
	
sudoku:
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push dx
	push cx
	push si

	mov ax, 0xb800   
	mov es, ax
	mov si, [bp + 4]        
	mov ax, [si + 2]       
	mov dx, [si]  
	mov bx, 80                ; Number of columns in text mode (80 characters per line)
	mul bx                    ; Multiply Y by 80 to get row offset
	add ax, [si]              ; Add X position to get column offset
	shl ax, 1                 ; Multiply by 2 because each character is 2 bytes
	mov di, ax                ; Store result in DI (video memory offset)
	mov cx, [si + 4]    
	add si, 6
nextChar:
	mov ax, [si]              ; Load character and attribute from line1
	mov [es:di], ax           ; Store in video memory
	add di, 2                 ; Move to the next position in video memory
	add si, 2                 ; Move to the next character in line1
	loop nextChar             ; Repeat for all characters in the line
	pop si
	pop cx
	pop dx
	pop bx
	pop ax
	pop es
	pop bp
	ret 2
	
sudoko2:
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push si

	mov ax, 0xb800   
	mov es, ax      
	mov ax, [bp + 8]  
	mov bx, 80                ; Number of columns in text mode (80 characters per line)
	mul bx                    ; Multiply Y by 80 to get row offset
	add ax, [bp + 10]              ; Add X position to get column offset
	shl ax, 1                 ; Multiply by 2 because each character is 2 bytes
	mov di, ax                ; Store result in DI (video memory offset)
	mov cx, [bp + 4]          ; Length of the string (in words, not bytes)
	mov si, [bp + 6]
next_loc:
	mov ax, [si]              ; Load character and attribute from line1
	mov [es:di], ax           ; Store in video memory
	add di, 2                 ; Move to the next position in video memory
	add si, 2                 ; Move to the next character in line1
	loop next_loc             ; Repeat for all characters in the line
	pop si
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 8
	
;============================== UNDO LARGE NUM + NOTES ==============================;

undo_large_num:
	push bp
	mov bp,sp
	push es
	push ax
	push bx
	push cx
	push si
	push di
	
	mov ax, 0xb800
	mov es, ax
    mov bx,word[index1]
	cmp bx,0
	je e1
	mov ax,word[box_call+bx]
	cmp ax,word[screen_flag]
	jne e1
	cmp byte[notes_nf+bx],1
	je space_print
	cmp word[no_inc_nc+bx],1
	je no_inc1
    push si
	push di
    mov ax,[enter_num1+bx]
	add ax,0x30
    mov si,[enter_num1+bx]
	sub si,1
    mov di,[num2+si]    
	inc di
	xor ax,ax
	mov ax,di
	mov byte[num2+si],al
	pop di
	pop si
	no_inc1:
	push si
	mov si,[save_box_no+bx]
	cmp byte[flag2],0
	jne med1
	mov word[dummyKeys1+si],0
	jmp ssss
med1:
	cmp byte[flag2],1
	jne hardd1
	mov word[dummyKeys2+si],0
	jmp ssss
hardd1:
	mov word[dummyKeys3+si],0	
ssss:
	pop si
	cmp word[screen_flag],1
	jne no_NC
;FrequencyofNumberCards
F_N_C1:
	mov si,0
	mov dx,0
NC11:
	mov ax ,dx
	add ax,2
	push ax
	mov ax,21
	push ax
	mov ax,0x7
	push ax
	mov ax,0x20
	push ax
	push 3
	call textback

	mov ax ,dx
	add ax,3
	push ax
	mov ax,21
	push ax
	mov ax,00001111b
	push ax
	mov ax,num2
	push ax
	push 1
	call print_str1
	add dx,7
	add si,1
	cmp si,9
	jne NC11
no_NC:
	mov di,[di_location+bx]
	sub word[index1],2
	mov word[di_location+bx],0
	mov word[enter_num1+bx],0	
	mov ax, 0x7020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	cmp word[score],0
	jbe skiiiip
	sub word[score],2
	mov ax, 74
	push ax
	mov ax, 6
	push ax
	mov ax, [score]
	push ax
	mov ax, 0x79
	push ax
	call print_num
skiiiip:
	jmp exit09
space_print:
	mov di,[di_location+bx]
	mov word[es:di],0x7020
	sub word[index1],2
	mov word[di_location+bx],0
	mov word[enter_num1+bx],0
	mov byte[notes_nf+bx],0
exit09:
	cmp word[box_call+bx],1
	je b2
	call highlightBox
	jmp e1
b2:
	call highlightBox2
e1:
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret
	
;============================== HIGHLIGHTING BOXES ==============================;

highlightBox:
	push bp
	mov bp,sp
	push es
	push ax
	push bx
	push cx
	push si
	push di
	
	mov ax, 0xb800
	mov es, ax
	mov bx, cursorXpos
	add bx, [Xprevious]
	mov si, cursorYpos
	add si, [Yprevious]	
	mov ax, 80
	mul word [si]
	add ax, [bx]
	shl ax, 1
	mov di, ax
    push di
    sub di,2
    mov si,0
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2  
    add di,160
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
     add di,160
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
	mov cx,24
	mov si,0
	mov byte[change_background],0
	mov ax,0x3020
loop12:
	cmp ax,word[save_num+si]
	jne num_exit
	add si,2
	loop loop12
	jmp skip101
num_exit: 
	mov byte[change_background],1

skip101:
	pop di
    push di
    sub di,2
    mov si,0
    mov ax,word[es:di]
	cmp ax,0x3c7c
    je red_num1
    add di,2
    add si,2
    mov ax,word[es:di]
	cmp ax,0x3c7c
    je red_num1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num1
    add di,2
    add si,2
    mov ax,word[es:di]
     cmp ax,0x3c7c
    je red_num1
    sub di,6
    add si,2
    
    add di,160
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num1
    sub di,6
    add si,2
     
    add di,160
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num1
    pop di
	push di
	mov ax, 0x7020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	pop di
	cmp byte[change_background],0
	je s09
	mov si,0
	sub di,2
    mov ax,word[save_num+si]
    mov ah,0x70
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x70
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    sub di,8
    add si,2
	jmp s09	
red_num1:
	pop di
	push di
	mov ax, 0x7020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	pop di
	mov si,0
	sub di,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    sub di,8
    add si,2
s09:
	mov bx, cursorXpos
	add bx, [Xcurrent]
	mov si, cursorYpos
	add si, [Ycurrent]	
	mov ax, 80
	mul word [si]
	add ax, [bx]
	shl ax, 1
	mov di, ax
   push di
    sub di,2
    mov si,0
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
    
    add di,160
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
    add di,160
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
    mov cx,24
	mov si,0
	mov byte[change_background],0
	mov ax,0x7020
loop1233:
	cmp ax,word[save_num+si]
	jne num_exit2

	add si,2
	loop loop1233
	jmp skip1019
num_exit2:
	mov byte[change_background],1

skip1019:
	pop di
    push di
    sub di,2
    mov si,0
    mov ax,word[es:di]
	cmp ax,0x7c7c
    je red_num2
    add di,2
    add si,2
    mov ax,word[es:di]
	cmp ax,0x7c7c
    je red_num2
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num2
    add di,2
    add si,2
    mov ax,word[es:di]
     cmp ax,0x7c7c
    je red_num2
    sub di,6
    add si,2
    
    add di,160
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num2
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num2
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num2
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num2
    sub di,6
    add si,2 
    add di,160
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num2
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num2
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num2
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num2
	
	pop di
	push di
	mov ax,0x3020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	pop di
	cmp byte[change_background],1
    jne exit99
	mov si,0
	sub di,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    sub di,8
    add si,2
	jmp exit99	
red_num2:
	pop di
	push di
	mov ax, 0x7020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	pop di
	mov si,0
	sub di,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    sub di,8
    add si,2
exit99:
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret
	
highlightBox2:
	push bp
	mov bp,sp
	push es
	push ax
	push bx
	push cx
	push si
	push di
	
	mov ax, 0xb800
	mov es, ax
	mov bx, cursorXpos
	add bx, [Xprevious]
	mov si, cursorYposForBoard2
	add si, [YpreviousForBoard2]
	
	mov ax, 80
	mul word [si]
	add ax, [bx]
	shl ax, 1
	mov di, ax
	
   push di
    sub di,2
    mov si,0
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
    
    add di,160
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
     
     add di,160
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
	mov cx,18
	mov si,0
	mov byte[change_background],0
	mov ax,0x3020
loop133:
	cmp ax,word[save_num+si]
	jne num_exit1
	add si,2
	loop loop133
	jmp skip1011
	num_exit1:
	mov byte[change_background],1
skip1011:
	pop di
    push di
    sub di,2
    mov si,0
    mov ax,word[es:di]
	cmp ax,0x3c7c
    je red_num13
    add di,2
    add si,2
    mov ax,word[es:di]
	cmp ax,0x3c7c
    je red_num13
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num13
    add di,2
    add si,2
    mov ax,word[es:di]
     cmp ax,0x3c7c
    je red_num13
    sub di,6
    add si,2
    
    add di,160
    mov ax,word[es:di]
      cmp ax,0x3c7c
    je red_num13
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num13
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num13
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num13
    sub di,6
    add si,2 
    add di,160
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num13
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num13
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num13
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x3c7c
    je red_num13
	
    pop di
	push di
	mov ax, 0x7020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	pop di
	cmp byte[change_background],0
	je s099
	mov si,0
	sub di,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x70 
    mov word[es:di],ax
    sub di,8
    add si,2
	jmp s099
red_num13:
	pop di
	push di
	mov ax, 0x7020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	pop di
	mov si,0
	sub di,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x7c 
    mov word[es:di],ax
    sub di,8
    add si,2
s099:
	mov bx, cursorXpos
	add bx, [Xcurrent]
	mov si, cursorYposForBoard2
	add si, [YcurrentForBoard2]
	mov ax, 80
	mul word [si]
	add ax, [bx]
	shl ax, 1
	mov di, ax
    push di
    sub di,2
    mov si,0
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
    
    add di,160
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
     
     add di,160
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
	add di,2
    add si,2
    mov ax,word[es:di]
    mov word[save_num+si],ax
    sub di,8
    add si,2
    mov cx,24
	mov si,0
	mov byte[change_background],0
	mov ax,0x7020
loop12333:
	cmp ax,word[save_num+si]
	jne num_exit29
	add si,2
	loop loop12333
	jmp skip101991
num_exit29: 
	mov byte[change_background],1
skip101991:
	pop di
    push di
    sub di,2
    mov si,0
    mov ax,word[es:di]
	cmp ax,0x7c7c
    je red_num23
    add di,2
    add si,2
    mov ax,word[es:di]
	cmp ax,0x7c7c
    je red_num23
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num23
    add di,2
    add si,2
    mov ax,word[es:di]
     cmp ax,0x7c7c
    je red_num23
    sub di,6
    add si,2
    
    add di,160
    mov ax,word[es:di]
       cmp ax,0x7c7c
    je red_num23
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num23
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num23
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num23
    sub di,6
    add si,2
     
     add di,160
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num23
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num23
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num23
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x7c7c
    je red_num23
	
skip10199:
	pop di
	push di
	mov ax,0x3020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	pop di
	cmp byte[change_background],1
    jne exit999
	mov si,0
	sub di,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    sub di,8
    add si,2

	add di,160
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    sub di,8
    add si,2
	
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x30 
    mov word[es:di],ax
    sub di,8
    add si,2
	jmp exit999	
red_num23:
	pop di
	push di
	mov ax, 0x7020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	pop di
	mov si,0
	sub di,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    sub di,8
    add si,2
	add di,160
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
	add di,2
    add si,2
    mov ax,word[save_num+si]
    mov ah,0x3c 
    mov word[es:di],ax
    sub di,8
    add si,2
		
exit999:
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret
	
;============================== FOR PRINTING ANY STRING IN A ROW ==============================;

textback:
	push bp
	mov bp,sp
	push es
	push ax
	push cx
	push si
	push di
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+10]
	add ax,[bp+12]
	shl ax,1
	mov di,ax
	mov si,[bp+6]
	mov cx,[bp+4]
	mov ah,[bp+8]
	nextchar5:
	mov al,[si]
	mov [es:di],ax
	add di,2
	loop nextchar5
	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 10

print_str:
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push dx
	push cx
	push si

	mov ax, 0xb800   
	mov es, ax       
	mov ax, [bp + 10]       
	mov bx, 80                ; Number of columns in text mode (80 characters per line)
	mul bx                    ; Multiply Y by 80 to get row offset
	add ax, [bp + 12]              ; Add X position to get column offset
	shl ax, 1                 ; Multiply by 2 because each character is 2 bytes
	mov di, ax                ; Store result in DI (video memory offset)
	mov si, [bp + 6]
	mov cx, [bp + 4]
	mov ah, [bp + 8]
	
next_char:
	mov al, [si]
	mov [es:di], ax
	add di, 2
	add si, 1
	loop next_char
	
	pop si
	pop cx
	pop dx
	pop bx
	pop ax
	pop es
	pop bp
	
	ret 10
	
;============================== PRINTING SCORE ==============================;

print_num:
	push bp 
    mov  bp, sp 
    push es 
	push ax 
	push bx 
    push cx 
    push dx 
    push di 
    mov  ax, 0xb800 
    mov  es, ax             ; point es to video base 
	mov al, 80
	mov bl, [bp+8]
	mul byte bl
	add ax, [bp+10]
	shl ax, 1
	mov di, ax
    mov  ax, [bp+6]         ; load number in ax 
    mov  bx, 10             ; use base 10 for division 
    mov  cx, 0              ; initialize count of digits 
nextdigit:
    mov  dx, 0              ; zero upper half of dividend 
    div  bx                 ; divide by 10 
    add  dl, 0x30           ; convert digit into ascii value 
    push dx                 ; save ascii value on stack 
	inc  cx                 ; increment count of values  
    cmp  ax, 0              ; is the quotient zero 
    jnz  nextdigit          ; if no divide it again 
nextpos:
	pop  dx                 ; remove a digit from the stack 
    mov  dh, [bp+4]          ; use normal attribute 
    mov [es:di], dx         ; print char on screen 
    add  di, 2              ; move to next screen location 
    loop nextpos            ; repeat for all digits on stack
    pop  di 
    pop  dx 
    pop  cx 
    pop  bx 
    pop  ax 
    pop  es 
    pop  bp 
    ret 8
	
;============================== STARTING SCREEN ==============================;
	
starting_screen:
	push bp
	mov bp, sp
	push ax
	
	call time_delay
	call time_delay
	call time_delay
	mov ax, line1
	push ax
	call sudoku
	call time_delay
	mov ax, line2
	push ax
	call sudoku
	call time_delay
	mov ax, line3
	push ax
	call sudoku
	call time_delay
	mov ax, line4
	push ax
	call sudoku
	call time_delay
	mov ax, line5
	push ax
	call sudoku
	mov ax, new_game1
	push ax
	call sudoku
	mov ax, new_game3
	push ax
	call sudoku
	
	mov ax, 35
	push ax
	mov ax, 15
	push ax
	mov ax, 0xBF
	push ax
	mov ax, new_game
	push ax
	push 10
	call print_str
	
	mov ax, end_game1
	push ax
	call sudoku
	mov ax, end_game3
	push ax
	call sudoku
	
	mov ax, 35
	push ax
	mov ax, 19
	push ax
	mov ax, 0x3F
	push ax
	mov ax, end_game
	push ax
	push 10
	call print_str
	
	pop ax
	pop bp
	ret
	
;============================== KEYBOARD INPUT FOR STARTING SCREEN ==============================;
	
wait_for_key:
    mov ah, 0x00       ; BIOS function 0x00: wait for key press
    int 16h           ; Call BIOS to get the key press
	
    cmp al, 0x0D       ; Check if Enter is pressed (0x0D is ASCII for Enter)
    je enter_key_for_startingScreen  ; If Enter, jump to handling Enter
    cmp ah, 0x48       ; Check if Up arrow (scan code 0x48)
    je up_key_for_startingScreen     ; If Up arrow, jump to handling Up
    cmp ah, 0x50       ; Check if Down arrow (scan code 0x50)
    je down_key_for_startingScreen   ; If Down arrow, jump to handling Down
	cmp al, 0x1B       ; Check if Escape is pressed (0x1B is ASCII for Escape)
	je ending_screen
    jmp wait_for_key   ; If other keys, keep waiting

up_key_for_startingScreen:
    mov al, [flag1]     ; Load current flag1
    cmp al, 0          ; If flag1 is 0 ("New Game" selected)
    je toggle_for_1    ; Switch to "End Game"
	cmp al, 1          ; If flag1 is 0 ("New Game" selected)
    je toggle_for_0    ; Switch to "End Game"
    jmp wait_for_key   ; Continue waiting for key

down_key_for_startingScreen:
    mov al, [flag1]     ; Load current flag1
    cmp al, 1          ; If flag1 is 1 ("End Game" selected)
    je toggle_for_0    ; Switch to "New Game"
	cmp al, 0          ; If flag1 is 1 ("End Game" selected)
    je toggle_for_1    ; Switch to "New Game"
    jmp wait_for_key   ; Continue waiting for key

enter_key_for_startingScreen:
    mov al, [flag1]     ; Load current flag1
    cmp al, 0          ; If flag1 is 0 ("New Game" selected)
    je start_new_game  ; Call new game starting routine
    cmp al, 1          ; If flag1 is 1 ("End Game" selected)
    je ending_screen	; Call end game routine
    jmp wait_for_key   ; Continue waiting for another key

toggle_for_1:
    mov byte [flag1], 1 ; Set flag1 to 1 ("End Game" selected)
    mov ax, 35
    push ax
    mov ax, 15
    push ax
    mov ax, 0x3F       ; Normal color
    push ax
    mov ax, new_game
    push ax
    push 10
    call print_str
    
    mov ax, 35
    push ax
    mov ax, 19
    push ax
    mov ax, 0xBF       ; Highlighted color
    push ax
    mov ax, end_game
    push ax
    push 10
    call print_str
    jmp wait_for_key

toggle_for_0:
    mov byte [flag1], 0 ; Set flag1 to 0 ("New Game" selected)
    mov ax, 35
    push ax
    mov ax, 15
    push ax
    mov ax, 0xBF       ; Highlighted color
    push ax
    mov ax, new_game
    push ax
    push 10
    call print_str
    
    mov ax, 35
    push ax
    mov ax, 19
    push ax
    mov ax, 0x3F       ; Normal color
    push ax
    mov ax, end_game
    push ax
    push 10
    call print_str
    jmp wait_for_key
	
;============================== LEVELS SCREEN ==============================;
	
levels_screen:
	mov byte [boxNo], 0
	mov word [Xcurrent], 0
	mov word [Ycurrent], 0
	mov byte [score], 0
	mov byte [mistakes], 0
	call reloadUndo

	mov dx,0
	mov ax ,0
	push ax
	push dx
	mov ax,01110111b
	push ax
	mov ax,0x20
	push ax
	push 4000
	call print_str
	mov dx,0
boundary:
	mov ax ,0
	push ax
	push dx
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 2
	call textback
	add dx,1
	cmp dx,24
	jne boundary
	mov dx,0
boundary1:
	mov ax ,78
	push ax
	push dx
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 2
	call textback
	add dx,1
	cmp dx,24
	jne boundary1
		
	mov ax ,0
	push ax
	mov ax,0
	push ax
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 80
	call textback

	mov ax ,0
	push ax
	mov ax,24
	push ax
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 80
	call textback
	call time_delay	
	;Select level
	mov ax ,24
	push ax
	mov ax,4
	push ax
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 24
	call textback
	call time_delay
	mov ax ,24
	push ax
	mov ax,5
	push ax
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 24
	call textback
	call time_delay
	mov ax ,24
	push ax
	mov ax,6
	push ax
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 24
	call textback
	call time_delay
	mov ax ,25
	push ax
	mov ax,5
	push ax
	mov ax,0x3f
	push ax
	mov ax,message
	push ax
	push word[length1]
	call print_str
	call time_delay
	;Low level print
	mov ax ,29
	push ax
	mov ax,9
	push ax
	mov ax,0x28
	push ax
	mov ax,0x20
	push ax
	push 12
	call textback
	call time_delay
	mov ax ,29
	push ax
	mov ax,10
	push ax
	mov ax,0x28
	push ax
	mov ax,0x20
	push ax
	push 12
	call textback
	call time_delay
	mov ax ,29
	push ax
	mov ax,11
	push ax
	mov ax,0x28
	push ax
	mov ax,0x20
	push ax
	push 12
	call textback
	call time_delay
	mov ax ,30
	push ax
	mov ax,10
	push ax
	mov ax,0xAf
	push ax
	mov ax,message1
	push ax
	push word[length2]
	call print_str
	call time_delay
	;Itermediate level print
	mov ax ,29
	push ax
	mov ax,13
	push ax
	mov ax,0x68
	push ax
	mov ax,0x20
	push ax
	push 19
	call textback
	call time_delay
	mov ax ,29
	push ax
	mov ax,14
	push ax
	mov ax,0x68
	push ax
	mov ax,0x20
	push ax
	push 19
	call textback
	call time_delay
	mov ax ,29
	push ax
	mov ax,15
	push ax
	mov ax,0x68
	push ax
	mov ax,0x20
	push ax
	push 19
	call textback
	call time_delay
	mov ax ,30
	push ax
	mov ax,14
	push ax
	mov ax,0x6f
	push ax
	mov ax,message2
	push ax
	push word[length3]
	call print_str
	call time_delay
	;Hard level print
	mov ax ,29
	push ax
	mov ax,17
	push ax
	mov ax,0x48
	push ax
	mov ax,0x20
	push ax
	push 12
	call textback
	call time_delay
	mov ax ,29
	push ax
	mov ax,18
	push ax
	mov ax,0x48
	push ax
	mov ax,0x20
	push ax
	push 12
	call textback
	call time_delay
	mov ax ,29
	push ax
	mov ax,19
	push ax
	mov ax,0x48
	push ax
	mov ax,0x20
	push ax
	push 12
	call textback
	call time_delay
	mov ax ,30
	push ax
	mov ax,18
	push ax
	mov ax,0x4f
	push ax
	mov ax,message3
	push ax
	push word[length4]
	call print_str
	
;============================== KEYBOARD INPUT FOR LEVELS SCREEN ==============================;
	
wait_for_key2:
	mov ah, 0x00       ; BIOS function 0x00: wait for key press
    int 0x16           ; Call BIOS to get the key press

    cmp al, 0x0D       ; Check if Enter is pressed (0x0D is ASCII for Enter)
    je enter_key_for_levelsScreen  ; If Enter, jump to handling Enter
    cmp ah, 0x48       ; Check if Up arrow (scan code 0x48)
    je up_key_for_levelsScreen     ; If Up arrow, jump to handling Up
    cmp ah, 0x50       ; Check if Down arrow (scan code 0x50)
    je down_key_for_levelsScreen   ; If Down arrow, jump to handling Down
	cmp al, 0x1B       ; Check if Escape is pressed (0x1B is ASCII for Escape)
	je ending_screen
	cmp ah, 0x0E       ; 0x0E -> scan code for bakspace key
	je start
	jmp wait_for_key2
	
up_key_for_levelsScreen:
    mov al, [flag2]     ; Load current flag1
    cmp al, 0          ; If flag2 is 0 ("HARD" selected)
    je toggle_with_2   ; Switch to "HARD"
	cmp al, 1          ; If flag2 is 0 ("EASY" selected)
    je toggle_with_0   ; Switch to "EASY"
	cmp al, 2          ; If flag2 is 0 ("MEDIUM" selected)
	je toggle_with_1    ; Switch to "MEDIUM"
    jmp wait_for_key2  ; Continue waiting for key

down_key_for_levelsScreen:
    mov al, [flag2]     ; Load current flag1
    cmp al, 1  ; If flag2 is 1 ("HARD" selected)
    je toggle_with_2  ; Switch to "HARD"
	cmp al, 0          ; If flag2 is 1 ("EASY" selected)
    je toggle_with_1    ; Switch to "EASY"
	cmp al, 2
	je toggle_with_0
    jmp wait_for_key2   ; Continue waiting for key

enter_key_for_levelsScreen:
    mov al, [flag2]     ; Load current flag1
    cmp al, 0          ; If flag2 is 0 ("" selected)
    je easy_game ; Call new game starting routine
    cmp al, 1          ; If flag2 is 1 ("" selected)
    je medium_game	; Call end game routine
	cmp al, 2
	je hard_game
    jmp wait_for_key2   ; Continue waiting for another key
	
toggle_with_0:
	mov byte[flag2],0
	mov ax ,25
	push ax
	mov ax,5
	push ax
	mov ax,0x3f
	push ax
	mov ax,message
	push ax
	push word[length1]
	call print_str
	mov ax ,30
	push ax
	mov ax,10
	push ax
	mov ax,10101111b
	push ax
	mov ax,message1
	push ax
	push word[length2]
	call print_str
	mov ax ,30
	push ax
	mov ax,14
	push ax
	mov ax,0x6f
	push ax
	mov ax,message2
	push ax
	push word[length3]
	call print_str  
	mov ax ,30
	push ax
	mov ax,18
	push ax
	mov ax,0x4f
	push ax
	mov ax,message3
	push ax
	push word[length4]
	call print_str
	jmp wait_for_key2

toggle_with_1:
    mov byte[flag2],1
    mov ax ,25
	push ax
	mov ax,5
	push ax
	mov ax,0x3f
	push ax
	mov ax,message
	push ax
	push word[length1]
	call print_str
	mov ax ,30
	push ax
	mov ax,10
	push ax
	mov ax,0x2f
	push ax
	mov ax,message1
	push ax
	push word[length2]
	call print_str
	mov ax ,30
	push ax
	mov ax,14
	push ax
	mov ax,0xef
	push ax
	mov ax,message2
	push ax
	push word[length3]
	call print_str    
	mov ax ,30
	push ax
	mov ax,18
	push ax
	mov ax,0x4f
	push ax
	mov ax,message3
	push ax
	push word[length4]
	call print_str
	jmp wait_for_key2	
	
toggle_with_2:
    mov byte[flag2],2
	mov ax ,25
	push ax
	mov ax,5
	push ax
	mov ax,0x3f
	push ax
	mov ax,message
	push ax
	push word[length1]
	call print_str
	mov ax ,30
	push ax
	mov ax,10
	push ax
	mov ax,0x2f
	push ax
	mov ax,message1
	push ax
	push word[length2]
	call print_str
	mov ax ,30
	push ax
	mov ax,14
	push ax
	mov ax,0x6f
	push ax
	mov ax,message2
	push ax
	push word[length3]
	call print_str    
	mov ax ,30
	push ax
	mov ax,18
	push ax
	mov ax,0xcf
	push ax
	mov ax,message3
	push ax
	push word[length4]
	call print_str
	jmp wait_for_key2

;============================== PRINTING STATS ==============================;

print_stats:
	mov byte [offTimer], 0
	mov ax, 65
	push ax
	mov ax, 0
	push ax
	mov ax, board4
	push ax
	push 15
	call sudoko2
	
	mov ax, 65
	push ax
	mov ax, 2
	push ax
	mov ax, 0x79
	push ax
	call print_mode
	
	mov ax, 65
	push ax
	mov ax, 4
	push ax
	mov ax, board4
	push ax
	push 15
	call sudoko2
	
	mov ax, 65
	push ax
	mov ax, 6
	push ax
	mov ax, 0x79
	push ax
	mov ax, score_str
	push ax
	push 13
	call print_str
	
	mov ax, 74
	push ax
	mov ax, 6
	push ax
	mov ax, [score]
	push ax
	mov ax, 0x79
	push ax
	call print_num
	
	mov ax, 65
	push ax
	mov ax, 8
	push ax
	mov ax, board4
	push ax
	push 15
	call sudoko2
	
	mov ax, 65
	push ax
	mov ax, 10
	push ax
	mov ax, 0x79
	push ax
	mov ax, mistakes_str1
	push ax
	push 14
	call print_str
	
	mov ax, 76
	push ax
	mov ax, 10
	push ax
	mov ax, [mistakes]
	push ax
	cmp byte [mistakes], 0
	je skipPrintRed
	mov ax, 0x74
	jmp notRed
skipPrintRed:
	mov ax, 0x79
notRed:
	push ax
	call print_num
	mov ax, 65
	push ax
	mov ax, 12
	push ax
	mov ax, board4
	push ax
	push 15
	call sudoko2
	
	mov ax, 65
	push ax
	mov ax, 14
	push ax
	mov ax, 0x79
	push ax
	mov ax, time_str
	push ax
	push 13
	call print_str
	
	mov ax, 65
	push ax
	mov ax, 16
	push ax
	mov ax, board4
	push ax
	push 15
	call sudoko2
	
	mov ax, 65
	push ax
	mov ax, 18
	push ax
	mov ax, 0x79
	push ax
	mov ax, notes_str
	push ax
	push 8
	call print_str
	call print_notes
	
	mov ax, 65
	push ax
	mov ax, 20
	push ax
	mov ax, board4
	push ax
	push 15
	call sudoko2
	
	mov ax, 65
	push ax
	mov ax, 22
	push ax
	mov ax, 0x79
	push ax
	mov ax, undo
	push ax
	push 14
	call print_str
	
	mov ax, 65
	push ax
	mov ax, 24
	push ax
	mov ax, board4
	push ax
	push 15
	call sudoko2
	call hookTimer
	ret
	
printStatsBoundary:
	push bp
	mov bp, sp
	push ax
	push es
	push di
	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte [bp+4]
	add ax, [bp+6]
	shl ax, 1
	mov di, ax
	mov word [es:di], 0x797C
	pop di
	pop es
	pop ax
	pop bp
	ret 4
	
;============================== (NOTES ON) PRINTING ON FIRST BOARD ==============================;

notes_on_print:
	push ax
	mov bx, cursorXpos
	add bx,word[Xcurrent]
	mov di, cursorYpos
	add di,word[Ycurrent]

	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[di]
	add ax,[bx]
	shl ax,1
	mov di,ax
	pop ax

    add word[index1],2
	push bx
	mov bx,word[index1]
	mov byte[notes_nf+bx],1
	mov word[box_call],0
	pop bx
	
    cmp al,0x2
    je p12
    cmp al,0x3
    je p22
    cmp al,0x4
    je p32
    cmp al,0x5
    je p42
    cmp al,0x6
    je p52
    cmp al,0x7
    je p62
    cmp al,0x8
    je p72
    cmp al,0x9
    je p82
    cmp al,0x0A
    je p92
p12:  
	sub di,2
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],1
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3031
	ret
p22:
	add di, 2   
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],2
	mov word[di_location+bx],di
	pop bx
	mov word[es:di],0x3032
	ret
p32:  
	add di, 6
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],3
	mov word[di_location+bx],di
	pop bx
	mov word[es:di],0x3033
	ret
p42:
	sub di,2
	add di,160
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],4
    mov word[di_location+bx],di
	pop bx
	mov word[es:di],0x3034
	ret
p52: 
	add di,160
	add di, 2
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],5
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3035
	ret
p62:  
	add di,6
	add di,160
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],6
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3036
	ret
p72: 
	sub di,2
	add di,320
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],7
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3037
	ret
p82: 
	add di, 2
	add di,320
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],8
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3038
	ret
p92:   
	add di,6
	add di,320
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],9
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3039
	ret
	
;============================== (NOTES ON) PRINTING ON SECOND BOARD ==============================;

notes_on_print1:
	push ax
	mov bx, cursorXpos
	add bx,word[Xcurrent]
	mov di, cursorYposForBoard2
	add di,word[YcurrentForBoard2]

	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[di]
	add ax,[bx]
	shl ax,1
	mov di,ax
	pop ax
	add word[index1],2
	push bx
	mov bx,word[index1]
	mov byte[notes_nf+bx],1
	mov word[box_call+bx],1
	pop bx
    cmp al,0x2
    je p122
    cmp al,0x3
    je p222
    cmp al,0x4
    je p322
    cmp al,0x5
    je p422
    cmp al,0x6
    je p522
    cmp al,0x7
    je p622
    cmp al,0x8
    je p722
    cmp al,0x9
    je p822
    cmp al,0x0A
    je p922
p122:  
	sub di,2
	mov word[es:di],0x3031
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],1
    mov word[di_location+bx],di
    pop bx
    ret
p222: 
	add di, 2  
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],2
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3032
	ret
p322:  
	add di,6
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],3
	mov word[di_location+bx],di
	pop bx
	mov word[es:di],0x3033
	ret
p422:
	sub di,2
	add di,160
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],4
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3034
	ret
p522: 
	add di, 2
	add di,160
	  push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],5
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3035
	ret
p622:  
	add di,6
	add di,160
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],6
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3036
	ret
p722: 
	sub di,2
	add di,320
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],7
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3037
	ret
p822: 
	add di, 2
	add di,320
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],8
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3038
	ret
p922:   
	add di,6
	add di,320
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],9
    mov word[di_location+bx],di
    pop bx
	mov word[es:di],0x3039
	ret

;============================== PRINT ENTER NUMBER ON FIRST BOARD  ==============================;

display_enter_num:
	push ax
	mov ax, 0xb800
	mov es, ax
	mov bx, cursorXpos
	add bx, [Xcurrent]
	mov si, cursorYpos
	add si, [Ycurrent]
	push bx
	push si
	mov ax, 80
	mul word [si]
	add ax, [bx]
	shl ax, 1
	mov di, ax

    push di
    sub di,2
    mov si,0
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    sub di,6
    add si,2
    add di,160
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    sub di,6
    add si,2
     
    add di,160
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there
	cmp ax,3c7ch
	je no_already_there
    pop di
	pop si
	pop bx
	pop ax
	cmp byte[notes],0
	je print_large
	call notes_on_print
	jmp exit1
print_large:
	push bx
	push si
	push ax
	push di
	push cx
	mov bx, cursorXpos
	add bx, [Xcurrent]
	mov si, cursorYpos
	add si, [Ycurrent]
	mov ax, 80
	mul word [si]
	add ax, [bx]
	shl ax, 1
	mov di, ax
	add word[index1],2
	push bx
	push dx
	mov bx,word[index1]
	mov word[di_location+bx],di
	mov byte[notes_nf+bx],0
	mov dx,[boxNo]
	mov word[save_box_no+bx],dx
	pop dx
	pop bx
	mov ax, 0x3020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	pop cx
	pop di
	pop ax
	pop si
	pop bx
	push bx
	push si
	cmp byte[flag2],0
	jne m1
	mov bx,keysEasyLvl
	jmp check_num
m1:
	cmp byte[flag2],1
	jne h1
	mov bx,keysMediumLvl
	jmp check_num
h1:
	mov bx,keysHardLvl
check_num:
	mov si,word[boxNo]
	push ax
	sub al,0x1
	cmp byte[bx+si],al
	jne wrong_input
	pop ax
	pop si
	pop bx	
	push bx
	mov bx,word[index1]
	mov word[box_call+bx],0	
	pop bx
	push ax
	add word[score], 2
	mov ax, 74
	push ax
	mov ax, 6
	push ax
	mov ax, [score]
	push ax
	mov ax, 0x79
	push ax
	call print_num
	pop ax	
	push ax
	mov byte [produceSound], 0
	cmp byte[flag2],0
	jne m2
	push bx
	mov bx,[boxNo]
	mov word[dummyKeys1+bx],1
	pop bx
	push dummyKeys1
	call checkIfRowIsCompleted
	push dummyKeys1
	call checkIfColIsCompleted
	cmp byte [produceSound], 0
	je skipSound
	push track
	push track_d
	push word [track_s]
	call play_track
skipSound:
	push dummyKeys1
	call checkIfGameIsCompleted
	jmp ch1
m2:
	cmp byte[flag2],1
	jne h2
	push bx
	mov bx,[boxNo]
	mov word[dummyKeys2+bx],1
	pop bx
	push dummyKeys2
	call checkIfRowIsCompleted
	push dummyKeys2
	call checkIfColIsCompleted
	cmp byte [produceSound], 0
	je skipSound1
	push track
	push track_d
	push word [track_s]
	call play_track
skipSound1:
	push dummyKeys2
	call checkIfGameIsCompleted
	jmp ch1
h2:
	push bx
	mov bx,[boxNo]
	mov word[dummyKeys3+bx],1
	pop bx
	push dummyKeys3
	call checkIfColIsCompleted
	push dummyKeys3
	call checkIfRowIsCompleted
	cmp byte [produceSound], 0
	je skipSound2
	push track
	push track_d
	push word [track_s]
	call play_track
skipSound2:
	push dummyKeys3
	call checkIfGameIsCompleted
ch1:
	pop ax
	push word[bx]
	push word[si]
	push 0x30
    cmp al,0x2
   je p1
    cmp al,0x3
   je p2
    cmp al,0x4
   je p3
    cmp al,0x5
   je p4
    cmp al,0x6
   je p5
    cmp al,0x7
   je p6
    cmp al,0x8
   je p7
    cmp al,0x9
   je p8
    cmp al,0x0A
   je p9
p1:  
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],1
	pop bx
	call print_1
	jmp rukh
p2:    
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],2
	pop bx
	call print_2
	jmp rukh
p3:    
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],3
	pop bx 
	call print_3
	jmp rukh
p4:
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],4
	pop bx   
	call print_4
	jmp rukh
p5:
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],5
    pop bx   
	call print_5
	jmp rukh
p6:
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],6
	pop bx   
	call print_6
	jmp rukh
p7:  
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],7
	pop bx
	call print_7
	jmp rukh
p8:   
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],8
	pop bx
	call print_8
	jmp rukh
p9:  
	push bx
	mov bx,word[index1]
	mov byte[enter_num1+bx],9
	pop bx
	call print_9

rukh:
    push si
	push di
	push bx
	mov bx,word[index1]
    mov ax,[enter_num1+bx]
	add ax,0x30
    mov si,[enter_num1+bx]
	sub si,1
    mov di,[num2+si]    
	dec di
	xor ax,ax
	mov ax,di
	mov byte[num2+si],al
	pop bx
	pop di
	pop si
	jmp exit1
no_already_there:
	pop di
	pop si
	pop bx
	pop ax
	jmp exit1
wrong_input:
	push track1
	push track_d1
	push word [track_s1]
	call play_track
	inc byte[mistakes]
	mov ax, 76
	push ax
	mov ax, 10
	push ax
	mov ax, [mistakes]
	push ax
	cmp byte[mistakes],0
	ja red1
	mov ax, 0x78
	push ax
	jmp pp
red1:
	mov ax, 0x7c
	push ax
pp:
	call print_num
	pop ax
    pop si
	pop bx
	push word[bx]
	push word[si]
	push 0x3c
    cmp al,0x2
   je w1
    cmp al,0x3
   je w2
    cmp al,0x4
   je w3
    cmp al,0x5
   je w4
    cmp al,0x6
   je w5
    cmp al,0x7
   je w6
    cmp al,0x8
   je w7
    cmp al,0x9
   je w8
    cmp al,0x0A
   je w9
w1: 
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],1
    pop bx   
	call print_1
	jmp o1
w2:
	call print_2
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],2
    pop bx   
	jmp o1
w3:
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],3
    pop bx   
	call print_3
	jmp o1
w4:
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],4
    pop bx   
	call print_4
	jmp o1
w5:
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],5
    pop bx   
	call print_5
	jmp o1
w6:
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],6
    pop bx   
	call print_6
	jmp o1
w7:
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],7
    pop bx   
	call print_7
	jmp o1
w8:
	call print_8
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],8
    pop bx   
	jmp o1
w9:
	call print_9
    push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],9
    pop bx   
    jmp o1
   
o1:
    push bx
    mov bx,word[index1]
    mov byte[no_inc_nc+bx],1
    pop bx 
	cmp byte[mistakes],3
    je ending_screen
	jmp exit1
;============================== ISR for KEY FOR FIRST BOARD ==============================;
	
keyIsr:
	mov ax, 0xb800
	mov es, ax
	in al, 0x60
	
	cmp al, 0x01
	je ending_screen
	cmp al, 0x0E
	je lev1
    mov word[screen_flag], 0	 
	cmp al, 0x50
	je moveDown
	cmp al, 0x48
	je moveUp
	cmp al, 0x4B
	je moveLeft
	cmp al, 0x4D
	je moveRight
    cmp al,0x16
    je undo_press
    cmp al,0x31
    je e11

    cmp al,0x2
    je display_enter_num
    cmp al,0x3
    je display_enter_num
    cmp al,0x4
    je display_enter_num
    cmp al,0x5
    je display_enter_num
    cmp al,0x6
    je display_enter_num
    cmp al,0x7
    je display_enter_num
    cmp al,0x8
    je display_enter_num
    cmp al,0x9
    je display_enter_num
    cmp al,0xa
    je display_enter_num
	jmp exit1

e11:
	cmp byte[notes], 0
	je nottoggleNotes
	mov byte[notes], 0
	jmp s01
nottoggleNotes:
	mov byte[notes], 1

s01:
	mov ax, 65
	push ax
	mov ax, 18
	push ax
	mov ax, 0x79
	push ax
	mov ax, notes_str
	push ax
	push 8
	call print_str
	call print_notes
	jmp exit1
	
moveUp:
	mov ax, [Ycurrent]
	cmp ax, 0
	je exit1
	mov bx, [Xcurrent]
	mov [Xprevious], bx
	mov [Yprevious], ax
	sub ax, 2
	mov [Ycurrent], ax
	sub word [boxNo], 18
	call highlightBox
	jmp exit1

moveDown:
	mov ax, [Ycurrent]
	cmp ax, 10
	jne skipGoingToBoard2
	mov dx, [Xcurrent]
	mov [dummy1], dx
	add word [boxNo], 18
	jmp goToSecondBoard
	
skipGoingToBoard2:
	mov bx, [Xcurrent]
	mov [Xprevious], bx
	mov [Yprevious], ax
	add ax, 2
	mov [Ycurrent], ax
	add word [boxNo], 18
	call highlightBox
	jmp exit1
	
moveRight:
	mov ax, [Xcurrent]
	cmp ax, 16
	je exit1
	mov bx, [Ycurrent]
	mov [Yprevious], bx
	mov [Xprevious], ax
	add ax, 2
	mov [Xcurrent], ax
	add word [boxNo], 2
	call highlightBox
	jmp exit1
	
moveLeft:
	mov ax, [Xcurrent]
	cmp ax, 0
	je exit1
	mov bx, [Ycurrent]
	mov [Yprevious], bx
	mov [Xprevious], ax
	sub ax, 2
	mov [Xcurrent], ax
	sub word [boxNo], 2
	call highlightBox
	jmp exit1
	
	undo_press:
	call undo_large_num
exit1:
	mov al, 0x20
	out 0x20, al

	iret
;============================== PRINT ENTER NUMBER ON SECOND BOARD  ==============================;
display_enter_num1:
	push ax
	mov ax, 0xb800
	mov es, ax
	mov bx, cursorXpos
	add bx, [Xcurrent]
	mov si,cursorYposForBoard2
	add si, [YcurrentForBoard2]
	push bx
	push si
	mov ax, 80
	mul word [si]
	add ax, [bx]
	shl ax, 1
	mov di, ax
    push di
    sub di,2
    mov si,0
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    sub di,6
    add si,2
    add di,160
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    sub di,6
    add si,2 
    add di,160
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
    je no_already_there1
	cmp ax,3c7ch
	je no_already_there1
    add di,2
    add si,2
    mov ax,word[es:di]
    cmp ax,0x307c
	je no_already_there1
   	cmp ax,3c7ch
	je no_already_there1
	pop di
	pop si
	pop bx
	pop ax
	cmp byte[notes],0
	je print_large1
	call notes_on_print1
	jmp exit1
print_large1:
	push bx
	push si
	push ax
	push di
	push cx
	mov bx, cursorXpos
	add bx, [Xcurrent]
	mov si, cursorYpos
	add si, [YcurrentForBoard2]
	mov ax, 80
	mul word [si]
	add ax, [bx]
	shl ax, 1
	mov di, ax
	
	add word[index1],2
	push bx
	push dx
	mov bx,word[index1]
	mov word[di_location+bx],di
	mov byte[notes_nf+bx],0
	mov word[box_call+bx],1
	mov dx,[boxNo]
	mov word[save_box_no+bx],dx
	pop dx
	pop bx
	mov ax, 0x3020
	mov cx, 5
	sub di, 2
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	mov cx, 5
	sub di, 10
	add di, 160
	cld
	rep stosw
	pop cx
	pop di
	pop ax
	pop si
	pop bx
	
	push bx
	push si
	cmp byte[flag2],0
	jne m11
	mov bx,keysEasyLvl
	jmp check_num1
m11:
	cmp byte[flag2],1
	jne h11
	mov bx,keysMediumLvl
	jmp check_num1
h11:
	mov bx,keysHardLvl
check_num1:
	mov si,word[boxNo]
	push ax
	sub al,0x1
	cmp byte[bx+si],al
	jne wrong_input1
	pop ax
	pop si
	pop bx
	push ax
	add word[score],2
	mov ax, 74
	push ax
	mov ax, 6
	push ax
	mov ax, [score]
	push ax
	mov ax, 0x79
	push ax
	call print_num
	pop ax
	push ax
	mov byte [produceSound], 0
	cmp byte[flag2],0
	jne m21
	push bx
	mov bx,word[boxNo]
	mov word[dummyKeys1+bx],1
	pop bx
	push dummyKeys1
	call checkIfRowIsCompleted
	push dummyKeys1
	call checkIfColIsCompleted
	cmp byte [produceSound], 0
	je skipSound3
	push track
	push track_d
	push word [track_s]
	call play_track
skipSound3:
	push dummyKeys1
	call checkIfGameIsCompleted
	jmp ch3

m21:
	cmp byte[flag2],1
	jne h21
	push bx
	mov bx,word[boxNo]
	mov word[dummyKeys2+bx],1
	pop bx
	push dummyKeys2
	call checkIfColIsCompleted
	push dummyKeys2
	call checkIfRowIsCompleted
	cmp byte [produceSound], 0
	je skipSound4
	push track
	push track_d
	push word [track_s]
	call play_track
skipSound4:
	push dummyKeys2
	call checkIfGameIsCompleted
	jmp ch3
h21:
	push bx
	mov bx,[boxNo]
	mov word[dummyKeys3+bx],1
	pop bx
	push dummyKeys3
	call checkIfColIsCompleted
	push dummyKeys3
	call checkIfRowIsCompleted
	cmp byte [produceSound], 0
	je skipSound5
	push track
	push track_d
	push word [track_s]
	call play_track
skipSound5:
	push dummyKeys3
	call checkIfGameIsCompleted
ch3:
	pop ax
	push word[bx]
	push word[si]
	push 0x30
	
    cmp al,0x2
   je p11
    cmp al,0x3
   je p21
    cmp al,0x4
   je p31
    cmp al,0x5
   je p41
    cmp al,0x6
   je p51
    cmp al,0x7
   je p61
    cmp al,0x8
   je p71
    cmp al,0x9
   je p81
    cmp al,0x0A
   je p91
p11: 
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],1
    pop bx
    call print_1
    jmp r1
p21:   
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],2
    pop bx
    call print_2
    jmp r1
p31:  
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],3
    pop bx
    call print_3
    jmp r1
p41:  
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],4
    pop bx 
    call print_4
    jmp r1
p51:   
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],5
    pop bx
    call print_5
    jmp r1
p61:  
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],6
    pop bx
    call print_6
    jmp r1
p71:  
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],7
    pop bx
    call print_7
    jmp r1
p81:  
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],8
    pop bx
    call print_8
    jmp r1
p91:  
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],9
    pop bx
    call print_9
r1:
    push si
	push di
	push bx
	mov bx,word[index1]
    mov ax,[enter_num1+bx]
	add ax,0x30
    mov si,[enter_num1+bx]
	sub si,1
    mov di,[num2+si]    
	dec di
	xor ax,ax
	mov ax,di
	mov byte[num2+si],al
	;FrequencyofNumberCards
F_N_C19:
	mov si,0
	mov dx,0
NC112:
	mov ax ,dx
	add ax,2
	push ax
	mov ax,21
	push ax
	mov ax,0x7
	push ax
	mov ax,0x20
	push ax
	push 3
	call textback
	mov ax ,dx
	add ax,3
	push ax
	mov ax,21
	push ax
	mov ax,00001111b
	push ax
	mov ax,num2
	push ax
	push 1
	call print_str1
	add dx,7
	add si,1
	cmp si,9
	jne NC112
	pop bx
	pop di
	pop si
    jmp exit2
no_already_there1:
	pop di
	pop si
	pop bx
	pop ax
	jmp exit2
wrong_input1:
	push track1
	push track_d1
	push word [track_s1]
	call play_track
	inc byte[mistakes]
	mov ax, 76
	push ax
	mov ax, 10
	push ax
	mov ax, [mistakes]
	push ax
	cmp byte[mistakes],0
	ja red2
	mov ax, 0x78
	push ax
	jmp pp1
red2:
	mov ax, 0x7c
	push ax
pp1:
	call print_num
    pop ax
    pop si
	pop bx
	push word[bx]
	push word[si]
	push 0x3c

    cmp al,0x2
   je w11
    cmp al,0x3
   je w21
    cmp al,0x4
   je w31
    cmp al,0x5
   je w41
    cmp al,0x6
   je w51
    cmp al,0x7
   je w61
    cmp al,0x8
   je w71
    cmp al,0x9
   je w81
    cmp al,0x0A
   je w91
w11: 
	call print_1
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],1
    pop bx
	jmp o11
w21:
	call print_2
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],2
    pop bx
	jmp o11
w31:
	call print_3
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],3
    pop bx
	jmp o11
w41:
	call print_4
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],4
    pop bx
	jmp o11
w51:
	call print_5
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],5
    pop bx
	jmp o11
w61:
	call print_6
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],6
    pop bx
	jmp o11
w71:
	call print_7
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],7
    pop bx
	jmp o11
w81:
	call print_8
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],8
    pop bx
	jmp o11
w91:
	call print_9
	push bx
    mov bx,word[index1]
    mov byte[enter_num1+bx],9
    pop bx
    jmp o11
o11:
    push bx
    mov bx,word[index1]
    mov byte[no_inc_nc+bx],1
    pop bx 
    cmp byte[mistakes],3
    je ending_screen
	jmp exit2
	
;============================== ISR for KEY FOR SECOND BOARD ==============================;
	
keyIsr2:
	in al, 0x60
	cmp al, 0x01       ; Check if Escape is pressed (0x1B is ASCII for Escape)
	je ending_screen
	cmp al, 0x0E
	je lev1
    mov word[screen_flag],1
	cmp al, 0x50
	je moveDown2
	cmp al, 0x48
	je moveUp2
	cmp al, 0x4B
	je moveLeft2
	cmp al, 0x4D
	je moveRight2
	cmp al,0x31  ;N
    je e112
    cmp al,0x16
	je undo_n1
    cmp al,0x2
    je display_enter_num1
    cmp al,0x3
    je display_enter_num1
    cmp al,0x4
    je display_enter_num1
    cmp al,0x5
    je display_enter_num1
    cmp al,0x6
    je display_enter_num1
    cmp al,0x7
    je display_enter_num1
    cmp al,0x8
    je display_enter_num1
    cmp al,0x9
    je display_enter_num1
    cmp al,0xa
    je display_enter_num1
	jmp exit2

e112:
	cmp byte[notes], 0
	je nottoggleNotes2
	mov byte[notes], 0
	jmp s02
nottoggleNotes2:
	mov byte[notes], 1
s02:
	mov ax, 65
	push ax
	mov ax, 18
	push ax
	mov ax, 0x79
	push ax
	mov ax, notes_str
	push ax
	push 8
	call print_str
	call print_notes
	jmp exit2
moveUp2:
	mov ax, [YcurrentForBoard2]
	cmp ax, 0
	jne skippp
	mov dx, [Xcurrent]
	mov [dummy], dx
	mov dx, [dummy1]
	mov [Xprevious], dx
	mov word [Yprevious], 10
	mov word [Ycurrent], 10
	sub word [boxNo], 18
	call printbroadwithoutdelay
skippp:
	mov bx, [Xcurrent]
	mov [Xprevious], bx
	mov [YpreviousForBoard2], ax
	sub ax, 2
	mov [YcurrentForBoard2], ax
	sub word [boxNo], 18
	call highlightBox2
	jmp exit2

moveDown2:
	mov ax, [YcurrentForBoard2]
	cmp ax, 4
	je exit2
	mov bx, [Xcurrent]
	mov [Xprevious], bx
	mov [YpreviousForBoard2], ax
	add ax, 2
	mov [YcurrentForBoard2], ax
	add word [boxNo], 18
	call highlightBox2
	jmp exit2
	
moveRight2:
	mov ax, [Xcurrent]
	cmp ax, 16
	je exit2
	mov bx, [YcurrentForBoard2]
	mov [YpreviousForBoard2], bx
	mov [Xprevious], ax
	add ax, 2
	mov [Xcurrent], ax
	add word [boxNo], 2
	call highlightBox2
	jmp exit2
	
moveLeft2:
	mov ax, [Xcurrent]
	cmp ax, 0
	je exit2
	mov bx, [YcurrentForBoard2]
	mov [YpreviousForBoard2], bx
	mov [Xprevious], ax
	sub ax, 2
	mov [Xcurrent], ax
	sub word [boxNo], 2
	call highlightBox2
	jmp exit2
	
	undo_n1:
	call undo_large_num
exit2:
	mov al, 0x20
	out 0x20, al
	iret

;============================== PRINTING BOARD FIRST HALF ==============================;
	
print_board:	
	mov word [sec], 0
	mov word [min], 0
	mov word [secondBoardSaved], 0
	mov byte [justEnd], 0
	mov ax ,0
	push ax
	mov ax,0
	push ax
	mov ax,01110111b
	push ax
	mov ax,0x20
	push ax
	push 4000
	call print_str

	call time_delay
	mov ax, 0
	push ax
	mov ax, 0
	push ax
	mov ax, board1
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 1
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 2
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 3
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 4
	push ax
	mov ax, board3
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 5
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 6
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 7
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 8
	push ax
	mov ax, board3
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 9
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 10
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 11
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 12
	push ax
	mov ax, board1
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 13
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 14
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 15
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 16
	push ax
	mov ax, board3
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 17
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 18
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 19
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 20
	push ax
	mov ax, board3
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 21
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 22
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 23
	push ax
	mov ax, board2
	push ax
	push 65
	call sudoko2
	
	call time_delay
	mov ax, 0
	push ax
	mov ax, 24
	push ax
	mov ax, board1
	push ax
	push 65
	call sudoko2
	
	mov word [Xcurrent], 0
	mov word [Ycurrent], 0
	mov word [Xprevious], 0
	mov word [Yprevious], 0
	call print_stats 
	cmp byte [levels], 0
	je start_easy_game
	cmp byte [levels], 1
	je start_medium_game
	cmp byte [levels], 2
	je start_hard_game
	
start_hard_game:              
	push word keysHardLvl
	push word dummyKeys3
	call moveRandom
	push word dummyKeys3
	jmp printRandom
	
start_medium_game:
	push word keysMediumLvl
	push word dummyKeys2
	call moveRandom
	push word dummyKeys2
	jmp printRandom

start_easy_game:
	push word keysEasyLvl
	push word dummyKeys1
	call moveRandom
	push word dummyKeys1
	jmp printRandom
	
printbroadwithoutdelay:
	mov al, 0x20
	out 0x20, al
	call unhookKey
	
	push di
	push si
	push ds
	push es
	
	call scrollDown
	
	mov ax, 0xb800
	mov es, ax
	mov di, 0
	mov si, bufferForFirstBoard
	mov cx, 2000
	cld
	rep movsw
	
	pop es
	pop ds
	pop si
	pop di
	
	call print_stats
	call highlightBox
	
	
;============================== KEY INPUT AFTER 1ST HALF BOARD ==============================;
wait_for_key22:
	
	xor ax, ax
	mov es, ax
	mov ax, [es:9*4]
	mov [oldisrForKey], ax
	mov ax, [es:9*4+2]
	mov [oldisrForKey+2], ax
	
	cli
	mov word [es:9*4], keyIsr
	mov [es:9*4+2], cs
	sti
	
	jmp $
	
lev1:
	mov word [sec], 0
	mov word [min], 0
	mov byte [offTimer], 1
	call unhookTimer
	mov al, 0x20
	out 0x20, al
	call unhookKey
	mov byte [flag2], 0
	call levels_screen
    
;============================== PRINTING BOARD SECOND HALF ==============================;

goToSecondBoard:
	mov al, 0x20
	out 0x20, al
	call unhookKey
	call scrollup
	mov byte [offTimer], 1
	call clear_screen
	cmp word [secondBoardSaved], 1
	je printSecondFromBuffer
	
	mov dx,0
boundaryR1:
	mov ax ,0
	push ax
	push dx
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 2
	call textback
	add dx,1
	cmp dx,12
	jne boundaryR1
		
	;2Colborder
	mov dx,0
boundaryR2:
	mov ax ,21
	push ax
	push dx
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 2
	call textback
	add dx,1
	cmp dx,12
	jne boundaryR2
		
	;3Colborder
	mov dx,0
boundaryR3:
	mov ax ,42
	push ax
	push dx
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 2
	call textback
	add dx,1
	cmp dx,12
	jne boundaryR3

	;4Colborder
	mov dx,0
boundaryR4:
	mov ax ,63
	push ax
	push dx
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 2
	call textback
	add dx,1
	cmp dx,12
	jne boundaryR4

		
		
	;RowDashes
	mov dx,4
boundarydash4:

	mov ax ,2
	push ax
	mov ax,dx
	push ax
	mov ax,01110011b
	push ax
	mov ax,mess2
	push ax
	push 62
	call textback
	add dx,4
	cmp dx,12
	jne boundarydash4
		
	;ColDashes
	mov cx,8
	mov dx,0
boundarydash1:
	mov ax ,cx
	push ax
	mov ax,dx
	push ax
	mov ax,01110011b
	push ax
	mov ax,mess1
	push ax
	push 1
	call textback
	add dx,1
	cmp dx,12
	jne boundarydash1
	mov dx,0
	add cx ,6
	cmp cx,20
	jne  boundarydash1

	mov cx,29
	mov dx,0
	boundarydash2:
	mov ax ,cx
	push ax
	mov ax,dx
	push ax
	mov ax,01110011b
	push ax
	mov ax,mess1
	push ax
	push 1
	call textback
	add dx,1
	cmp dx,12
	jne boundarydash2
	mov dx,0
	add cx ,6
	cmp cx,41
	jne  boundarydash2

	mov cx,50
	mov dx,0
boundarydash3:
	mov ax ,cx
	push ax
	mov ax,dx
	push ax
	mov ax,01110011b
	push ax
	mov ax,mess1
	push ax
	push 1
	call textback
	add dx,1
	cmp dx,12
	jne boundarydash3
	mov dx,0
	add cx ,6
	cmp cx,62
	jne  boundarydash3
		
	;2Colborder
	mov dx,0
boundaryR22:
	mov ax ,21
	push ax
	push dx
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 2
	call textback
	add dx,1
	cmp dx,12
	jne boundaryR22
		
	;3Colborder
	mov dx,0
boundaryR32:
	mov ax ,42
	push ax
	push dx
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 2
	call textback
	add dx,1
	cmp dx,12
	jne boundaryR32

	;4Colborder
	mov dx,0
boundaryR42:
	mov ax ,63
	push ax
	push dx
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 2
	call textback
	add dx,1
	cmp dx,12
	jne boundaryR42
		
	;2Rowborder
	mov ax ,0
	push ax
	mov ax,12
	push ax
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 65
	call textback

	;1Rowborder
	mov ax ,0
	push ax
	mov ax,0
	push ax
	mov ax,0xb8
	push ax
	mov ax,0x20
	push ax
	push 65
	call textback	
;============================== PRINTING NUMBERS CARD ==============================;

	mov dx,0
	mov si,0
NC:
	mov ax ,dx
	add ax,1
	push ax
	mov ax,17
	push ax
	mov ax,0x97
	push ax
	mov ax,0x20
	push ax
	push 6
	call textback

	mov ax ,dx
	add ax,1
	push ax
	mov ax,18
	push ax
	mov ax,0x97
	push ax
	mov ax,0x20
	push ax
	push 6
	call textback

	mov ax ,dx
	add ax,1
	push ax
	mov ax,19
	push ax
	mov ax,0x97
	push ax
	mov ax,0x20
	push ax
	push 6
	call textback

	mov ax ,dx
	add ax,3
	push ax
	mov ax,18
	push ax
	mov ax,1eh
	push ax
	mov ax,num1
	push ax
	push 1
	call print_str1
	add dx,7
	add si,1
	cmp si,9
	jne NC

	;FrequencyofNumberCards
	mov si,0
	mov dx,0
NC1:

	mov ax ,dx
	add ax,2
	push ax
	mov ax,21
	push ax
	mov ax,0x7
	push ax
	mov ax,0x20
	push ax
	push 3
	call textback

	mov ax ,dx
	add ax,3
	push ax
	mov ax,21
	push ax
	mov ax,00001111b
	push ax
	mov ax,num2
	push ax
	push 1
	call print_str1
	add dx,7
	add si,1
	cmp si,9
	jne NC1
	mov ax, 64
	mov bx, 13
	mov cx, 12
loopNC:
	push ax
	push bx
	call printStatsBoundary
	add ax, 80
	loop loopNC
	
	call print_stats
	call scrollDown
	mov word [secondBoardSaved], 1
	cmp byte [levels], 0
	je start_easy_game1
	cmp byte [levels], 1
	je start_medium_game1
	cmp byte [levels], 2
	je start_hard_game1
start_hard_game1:
	push word dummyKeys3
	jmp printRandom1
start_medium_game1:
	push word dummyKeys2
	jmp printRandom1
start_easy_game1:
	push word dummyKeys1
	jmp printRandom1
	
printSecondFromBuffer:
	
	mov ax, 0xb800
	mov es, ax
	mov di, 0
	mov si, bufferForSecondBoard
	mov cx, 2000
	cld
	rep movsw
	mov dx, [dummy]
	mov [Xprevious], dx
	mov word [YpreviousForBoard2], 0
	mov word [YcurrentForBoard2], 0
	call print_stats
	call highlightBox2

	;FrequencyofNumberCards
	F_N_C12:
	mov si,0
	mov dx,0
NC111:

	mov ax ,dx
	add ax,2
	push ax
	mov ax,21
	push ax
	mov ax,0x7
	push ax
	mov ax,0x20
	push ax
	push 3
	call textback

	mov ax ,dx
	add ax,3
	push ax
	mov ax,21
	push ax
	mov ax,00001111b
	push ax
	mov ax,num2
	push ax
	push 1
	call print_str1
	add dx,7
	add si,1
	cmp si,9
	jne NC111
	
wait_for_key222:
	
	xor ax, ax
	mov es, ax
	mov ax, [es:9*4]
	mov [oldisrForKey], ax
	mov ax, [es:9*4+2]
	mov [oldisrForKey+2], ax
	
	cli
	mov word [es:9*4], keyIsr2
	mov [es:9*4+2], cs
	sti
	jmp $

;============================== ACTIONS AFTER KEYBOARD INPUTS ==============================;

start_new_game:
	push track2
    push track_d2
    push word [track_s2]
    call play_track
	mov byte [levels], 0
    call levels_screen
	jmp wait_for_key2
	
easy_game:
	push track2
    push track_d2
    push word [track_s2]
    call play_track
	mov byte [game_completed], 0
	mov byte [levels], 0
	push dummyKeys1
	push dummyKeys12
	call reloadDummys
	push cardFreq1
	call loadFreq
	call clear_screen
	call print_board
	jmp end
		
medium_game:
	push track2
    push track_d2
    push word [track_s2]
    call play_track
	mov byte [game_completed], 0
	mov byte [levels], 1
	push dummyKeys2
	push dummyKeys22
	call reloadDummys
	push cardFreq2
	call loadFreq
	call clear_screen
	call print_board
	jmp end
	
hard_game:
	push track2
    push track_d2
    push word [track_s2]
    call play_track
	mov byte [game_completed], 0
	mov byte [levels], 2
	push dummyKeys3
	push dummyKeys32
	call reloadDummys
	push cardFreq3
	call loadFreq
	call clear_screen
	call print_board
	jmp end
	
ending_screen:


	cmp byte [justEnd], 1
	je endSimply
	mov byte [offTimer], 1
	call unhookTimer
	mov al, 0x20
	out 0x20, al
	call unhookKey
endSimply:
	call background_frame
	mov ax, end_screen1
	push ax
	call sudoku
	call time_delay
	
	mov ax, end_screen2
	push ax
	call sudoku
	call time_delay
	
	mov ax, end_screen3
	push ax
	call sudoku
	call time_delay
	
	mov ax, end_screen4
	push ax
	call sudoku
	call time_delay
	
	mov ax, 30
	push ax
	mov ax, 7
	push ax
	cmp byte [game_completed], 1
	jne userLostGame
	mov ax, 0x0e
	push ax
	mov ax, game_won
	push ax
	push 19
	call print_str
	jmp skipy
userLostGame:
	cmp byte [justEnd], 1
	je printGameOver
	mov ax, 0x04
	push ax
	mov ax, game_loss
	push ax
	push 19
	call print_str
	jmp skipy
printGameOver:
	mov ax, 0x0e
	push ax
	mov ax, game_over
	push ax
	push 19
	call print_str
skipy:
	mov ax, end_screen5
	push ax
	call sudoku
	call time_delay
	
	mov ax, end_screen6
	push ax
	call sudoku
	call time_delay
	
	mov ax, end_screen7
	push ax
	call sudoku
	call time_delay
	
	mov ax, 25
	push ax
	mov ax, 10
	push ax
	mov ax, 0x1e
	push ax
	mov ax, score_str
	push ax
	push 13
	call print_str
	
	mov ax, 28
	push ax
	mov ax, 11
	push ax
	push ax
	mov ax, [score]
	mov ax, 0x3f
	push ax
	call print_num
	
	mov ax, 42
	push ax
	mov ax, 10
	push ax
	mov ax, 0x1e
	push ax
	mov ax, Difficulty_str
	push ax
	push 13
	call print_str
	
	mov ax, end_screen8
	push ax
	call sudoku
	call time_delay
	
	mov ax, 32
	push ax
	mov ax, 11
	push ax
	mov ax, [score]
	push ax
	mov ax, 0x3f
	push ax
	call print_num
	
	mov ax, 42
	push ax
	mov ax, 11
	push ax
	mov ax, 0x3f
	push ax
	cmp byte [flag1], 1
	je skip1
	cmp byte [flag2], 0
	je skip2
	cmp byte [flag2], 1
	je skip3
	cmp byte [flag2], 2
	je skip4

skip1:
	mov ax, Null
	push ax
	push 13
	jmp skip
skip2:
	mov ax, easy
	push ax
	push 6
	jmp skip
skip3:
	mov ax, medium
	push ax
	push 13
	jmp skip
skip4:
	mov ax, hard
	push ax
	push 6
	jmp skip
skip:
	call print_str
	
	mov ax, end_screen9
	push ax
	call sudoku
	call time_delay
	
	mov ax, end_screen10
	push ax
	call sudoku
	call time_delay
	
	mov ax, end_screen11
	push ax
	call sudoku
	call time_delay
	
	mov ax, 25
	push ax
	mov ax, 14
	push ax
	mov ax, 0x1e
	push ax
	mov ax, time_str
	push ax
	push 13
	call print_str
	
	mov ax, 42
	push ax
	mov ax, 14
	push ax
	mov ax, 0x1e
	push ax
	mov ax, mistakes_str
	push ax
	push 13
	call print_str
	
	mov ax, end_screen12
	push ax
	call sudoku
	call time_delay
	
	mov ax, 30
	push ax
	mov ax, 15
	push ax
	mov ax, [min]
	push ax
	mov ax, 0x3f
	push ax
	call print_num
	
	mov ax, 32
	push ax
	mov ax, 15
	push ax
	mov ax, 0x3f
	push ax
	mov ax, colon
	push ax
	push 3
	call print_str
	
	mov ax, 35
	push ax
	mov ax, 15
	push ax
	mov ax, [sec]
	push ax
	mov ax, 0x3f
	push ax
	call print_num
	
	mov ax, 50
	push ax
	mov ax, 15
	push ax
	mov ax, [mistakes]
	push ax
	mov ax, 0x3F
	push ax
	call print_num
	
	mov ax, end_screen13
	push ax
	call sudoku
	call time_delay
	
	mov ax, end_screen14
	push ax
	call sudoku
	call time_delay
	
	mov ax, end_screen15
	push ax
	call sudoku
	call time_delay
		jmp snd1

; Extended Victory Sound Melody
melody:
    dw 800, 1000, 1200, 1400, 1600  ; Initial rising excitement
    dw 1800, 2000, 2200             ; Climactic high notes
    dw 2000, 1800, 1600, 1400       ; Descending triumphant tones
    dw 1200, 1400, 1600, 1800, 2000 ; Secondary celebratory rise
    dw 2200, 2400, 2600             ; Final triumphant high notes
    dw 2000, 1800, 1600             ; Gentle resolution

tempo: dw 8       ; Faster tempo for an exciting, dynamic sound

delay:
    push cx
    push dx
    mov dx, [tempo] ; Use tempo for dynamic delay control
l2:
    mov cx, 0x6fff ; Longer delay for celebratory pacing
l1:
    loop l1
    dec dx
    cmp dx, 0
    jne l2
    pop dx
    pop cx
    ret

play_note:
    push ax         ; Save registers
    push bx
    push dx
    mov bx, [melody + si] ; Access the divisor for the current note
    call sound1      ; Call the sound function to play the note

    pop dx          ; Restore registers
    pop bx
    pop ax
    ret

sound1:
    ; Save current state of port 0x61 (speaker state)
    in al, 61h
    push ax         ; Save the AL value (mode of port 0x61)

    ; Enable the speaker and connect it to channel 2
    or al, 3h
    out 61h, al

    ; Set channel 2 (PIT)
    mov al, 0b6h    ; Select mode 3 (square wave) for channel 2
    out 43h, al

    ; Send the divisor to the PIT
    mov ax, bx      ; Load the divisor into AX
    out 42h, al     ; Send the LSB (lower byte)
    mov al, ah      ; Get the MSB (higher byte)
    out 42h, al     ; Send the MSB (higher byte)

    call delay      ; Play the sound for a duration based on delay

    ; Restore the previous state of port 0x61
    pop ax          ; Restore speaker state
    out 61h, al
    ret

snd1:
    mov si, 0       ; Start with the first note in the array
    mov cx, 19      ; Number of notes in the melody
play_loop:
    call play_note  ; Play the current note
    add si, 2       ; Move to the next note
    loop play_loop  ; Repeat until all notes are played

wait_for_key2222:	
	mov ah, 0       ; BIOS function 0x00: wait for key press
    int 0x16           ; Call BIOS to get the key press
	cmp ah, 0x1C       ; Check if Enter is pressed (0x0D is ASCII for Enter)
	je end
	cmp ah, 0x0E       ; 0x0E -> scan code for bakspace key
	je start
	jmp wait_for_key2222
	
;============================== MAIN FUNCTION ==============================;

start:
	mov byte [game_completed], 0
	mov word [score], 0
	mov byte [mistakes], 0
    mov byte [flag1], 0
	mov byte [flag1], 0
	mov byte [flag2], 0
	mov word [boxNo], 0
    call background_frame  ; Clear and print the screen with borders
	call starting_screen
	jmp wait_for_key

;============================== END OF PROGRAM ==============================;
    
end:
    mov ax, 0x4c00        ; Terminate the program
    int 0x21              ; DOS interrupt to exit