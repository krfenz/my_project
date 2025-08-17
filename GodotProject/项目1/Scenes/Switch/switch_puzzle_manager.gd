extends Marker2D
signal puzzle_solved
signal puzzle_failed
var score: int
@export var target_score:int=2

func increase_score():
	score+=1
	if score>=target_score:
		puzzle_solved.emit()
		print("123666")
	
func decrease_score():
	score-=1
	if score<target_score:
		puzzle_failed.emit()
	
