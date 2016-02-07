from firebase import firebase
from pprint import pprint

firebase = firebase.FirebaseApplication("https://glaring-torch-8449.firebaseio.com/", authentication=None)

result = firebase.get('/courses', None)

# pprint(result)

# for course, obj in result.iteritems():
	# print obj['description']


def search(word, depts = []): #dept is optional
	courseList = []
	for course, obj in result.iteritems():
		des = obj['description']
		title = obj['title']
		name = obj['name']

		if len(depts) == 0 or name[0:4] in depts: 
			if word in des or word in title:
			    courseList.append((course, obj))
    
	return courseList

# pprint(search("organic"))
# pprint(search("organic", ["CSCI", "ECON"]))
#pprint(search("animation"))
# pprint(search("introduction", ["CSCI", "ECON"]))
