from firebase import firebase
from pprint import pprint

firebase = firebase.FirebaseApplication("https://glaring-torch-8449.firebaseio.com/", authentication=None)
result = firebase.get('/courses', None)


def search(words, depts = []): # word and dept are optional
	if words == None:
		return "Enter at least one keyword."

	keyword_list_temp = words.split(",") #now words is an array of keywords, separated by commas
	keyword_list = []

	for elt in keyword_list_temp:
		keyword_list.append(elt.strip()) #removing whitespaces before a word

	courseList = []

	for course, obj in result.iteritems():
		des = obj['description']
		title = obj['title']
		name = obj['name']


		if len(depts) == 0 or name[0:4] in depts: 
			for word in keyword_list:
				if word in des or word in title:
				    courseList.append((course, obj))
    
	return courseList

# pprint(search("organic, money, labor"))
pprint(search("organic,      money, labor"))
# pprint(search("organic, money, labor"))
# pprint(search("organic", ["CSCI", "ECON"]))
# pprint(search("animation"))
# pprint(search("introduction", ["CSCI", "ECON"]))
