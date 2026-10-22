#Bölüm 1

#Soru 1.1

#Tahminim tuttu benim tahminimde total=14 result[7,9,5,1] idi
#Sonucta ayni sekilde total=14 result[7,9,5,1] 
numbers = [4, 7, 2, 9, 5, 1, 8]
total = 0
result = []

for i in range(len(numbers)):
    if numbers[i] % 2 == 0:
        total = total + numbers[i]
    else:
        result.append(numbers[i])

print(total)
print(result)


#Soru 1.2

#Sözde Kod

#current = 0
#top = 0

#readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]
#threshold = 22

#her bir sayı için;
    #eğer sayı > threshold
       #current = current + 1
    #eğer current > top
     #top = current  
    #değilse
        #current = 0
    
#top u yazdır

# Normal Kod

current = 0
top = 0

readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]

threshold = 22

for e in readings:
  if e > threshold:
    current = current + 1
    if current > top:
      top = current
  else:
    current = 0

print(top)

#Soru 1.3

records = [
    {"student": "Ece", "course": "VTYS"},
    {"student": "Ali", "course": "Yapay Zeka"},
    {"student": "Ece", "course": "Yapay Zeka"},
    {"student": "Can", "course": "VTYS"},
    {"student": "Ali", "course": "VTYS"},
    {"student": "Ece", "course": "Robotik"},
]

counts = {}

for record in records:
  course = record["course"]
  if course in counts:
    counts[course] = counts[course] + 1
  else:
    counts[course] = 1

print(counts)