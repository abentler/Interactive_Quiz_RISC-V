.data

.globl askname name
askname:	.string "Let's find out which character from the Pixar classic movie, 'Ratatouille,' best matches your personality.\nWhat is your name? "
name:		.space 10

.globl Q1 Q2 Q3
Q1:    	 .string  "\nChoose a shoe for a night on the town.\n   1 - Barefoot.\n   2 - Crocs.\n   3 - Converse.\n   4 - Boots.\n"
Q2:    	 .string  "\nWhat is your driving style?\n   1 - Fast but responsible.\n   2 - I lane split in my vespa because it's legal in CA.\n   3 - I don't drive. #savetheearth\n   4 - My license is suspended.\n"
Q3:      .string  "\nWhat is your go-to dinner?\n   1 - Some bread.\n   2 - Fresh pasta that I make myself.\n   3 - Idk bro I just grab some spices and get creative.\n   4 - Just grab some mystery leftovers from the back of the fridge.\n"

.globl Q1Ans Q2Ans Q3Ans
Q1Ans:	.word 8 0 4 12
Q2Ans:	.word 12 8 0 4
Q3Ans:	.word 4 12 8 0

.globl Result1 Result2 Result3 Result4
Result1:	.string  " is most like Remi's Brother, Emil. You have a big heart and love eating garbage."
Result2:	.string  " is most like Linguini lol."
Result3:	.string  " is most like Remi. Go take on the world."
Result4:	.string  " is most like Colleen. Sheesh."