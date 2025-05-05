- SQL files and migrations are in the migrations folder. Each migration will have a sql file and an md file. The md file
  will be used to generate the sql file. The migrations are numbered with a three digit number starting with 000.
- Reusable components go in the components folder. The app folder is dedicated for routing based components.
- The SQL dialect is postgres 18
- All mutating actions in SQL should be implemented as procedures instead of functions.
