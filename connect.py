#
# Author - Shuber Ali Mirza
# ID ----- 20027047
#

import mysql.connector

# Credentials
serverHost = input('Enter the MySQL server host: ')
uname = input('Enter a valid MySQL server username: ')
upass = input('Enter password: ')

# Connecting to mysql
try:
    conn = mysql.connector.connect(user = uname, password = upass, host = serverHost, database = 'f1')
except:
    print('ERROR - Invalid credentials')
cursor = conn.cursor() # Cursor object used for UI

# Queries to show individual tables
shTeams = "SELECT * FROM Teams"
shDrivers = "SELECT * FROM Drivers"
shSuppliers = "SELECT * FROM Suppliers"
shCircuits = "SELECT * FROM Circuits"
shRaces = "SELECT * FROM Races"
shWinners = "SELECT * FROM Winners"
shTyres = "SELECT * FROM Tyres"

# Queries from queries.sql file
q1 = ('SELECT D.teamName, T.fullName, SUM(D.points) AS ContructorPoints'
    ' FROM Drivers AS D INNER JOIN Teams AS T'
    ' ON D.teamName = T.teamName GROUP BY D.teamName')

q2 = ("SELECT dNo, CONCAT(fName, ' ', lName) AS 'Full Name', teamName, points"
    " FROM Drivers ORDER BY teamName")

q3 = ("SELECT dNo, fName, lName, raceID FROM Drivers NATURAL LEFT JOIN Winners")

q4 = ("SELECT dNo, fName, lName, fullName AS 'Team Full Name', chassis"
    " FROM Drivers INNER JOIN Teams"
    " WHERE Drivers.teamName = Teams.teamName")

q5 = ("SELECT raceID, raceName, country, DATE_FORMAT(day1Date, '%e/%m/%Y') AS 'Day 1 Date',"
    " DATE_FORMAT(raceDate, '%e/%m/%Y') AS 'Race Date'"
    " FROM Races NATURAL JOIN Circuits"
    " WHERE day1Date > '2022-03-31' AND day1Date < '2022-06-01'")

q6_1 = ("SELECT * FROM Suppliers WHERE name = 'Mercedes'")

q6_2 = ("SELECT COUNT(*) AS 'Num of Teams Using Mercedes pUnit'"
    " FROM Suppliers WHERE name = 'Mercedes'")

q7 = ("SELECT dNo, CONCAT(fName, ' ', lName) AS 'Full Name', chassis, D.points"
    " FROM Drivers AS D INNER JOIN Teams AS T"
    " WHERE D.points = (SELECT MAX(points) FROM Drivers)"
    " AND D.teamName = T.teamName")

q8 = ("SELECT hardestTyre, COUNT(hardestTyre) AS 'No. of Circuits Used in'"
    " FROM Circuits"
    " GROUP BY hardestTyre"
    " ORDER BY hardestTyre LIMIT 1")

q9 = ("SELECT * FROM Drivers AS D1"
    " WHERE points > (SELECT points FROM Drivers AS D2"
                " WHERE D1.teamName=D2.teamName AND D1.dNo<>D2.dNo)")

# Advanced features
v1 = "SELECT * FROM driverStand"
v2 = "SELECT * FROM constructorStand"

# Menu options for the user
print('''Welcome to the Formula 1 database
Options:
\tQ \tQuit
\tS \tDisplay the Suppliers table
\tTM \tDisplay the Teams table
\tD \tDisplay the Drivers table
\tTR \tDisplay the Tyres table
\tC \tDisplay the Circuits table
\tR \tDisplay the Races table
\tW \tDisplay the Winners table
\tDS \tDisplay current driver standings
\tCS \tDisplay current constructor standings
\t1-9 \tNumber of query you want to display (there are 9, respectively)
''')

option = None
# list used to display the results if option present in the list. Used to reduce code redundancy
options = ['s', 'tm', 'd', 'tr', 'c', 'r', 'w', 'ds', 'cs', '1', '2', '3', '4', '5', '6', '7', '8', '9']

# Switch case for the options, in a while loop, until menu exited
while option != 'q':
    option = input('\nEnter option: ').lower()
    if option == 'q':
        pass
    elif option == 's':
        cursor.execute(shSuppliers)
    elif option == 'tm':
        cursor.execute(shTeams)
    elif option == 'd':
        cursor.execute(shDrivers)
    elif option == 'tr':
        cursor.execute(shTyres)
    elif option == 'c':
        cursor.execute(shCircuits)
    elif option == 'r':
        cursor.execute(shRaces)
    elif option == 'w':
        cursor.execute(shWinners)
    elif option == 'ds':
        cursor.execute(v1)
    elif option == 'cs':
        cursor.execute(v2)
    elif option == '1':
        cursor.execute(q1)
    elif option == '2':
        cursor.execute(q2)
    elif option == '3':
        cursor.execute(q3)
    elif option == '4':
        cursor.execute(q4)
    elif option == '5':
        cursor.execute(q5)
    elif option == '6':
        cursor.execute(q6_1)
        for ii in cursor:
            print(ii)
        cursor.execute(q6_2)
    elif option == '7':
        cursor.execute(q7)
    elif option == '8':
        cursor.execute(q8)
    elif option == '9':
        cursor.execute(q9)
    else:
        print('ERROR - Unknown option')
    # printing the results from the queries
    for i in options:
        if option == i:
            for ii in cursor:
                print(ii)

cursor.close()
conn.close()
print('Bye!')
