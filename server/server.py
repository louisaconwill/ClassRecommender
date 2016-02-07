from firebase import firebase

firebase = firebase.FirebaseApplication(
"https://glaring-torch-8449.firebaseio.com/", authentication=None)

result = firebase.get('/courses', None)
print result

#def newUser(response):
#   print "a new user was created", response



#firebase.get_async('/users', None, callback=newUser)

users = firebase.get('/users', None)

print users

path = '/users/'
for u in users:
    url = path + u
    firebase.patch(url, {'courses': result})
    print u

