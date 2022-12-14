extends GutTest

func before_all():
	gut.p("test1")

func test_Assert():
	assert_eq(1,1,"heyo this test is dumb")
