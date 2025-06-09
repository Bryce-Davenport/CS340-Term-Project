# CS340_Term_Project

This repository hosts Bryce Davenport and Jack Armstrong's CS340 Term Project: Crazy Computers

### Project Citation
- Date: 06/09/25
- Scope: Project
- Based on: Activity 2
- Source URL: https://canvas.oregonstate.edu/courses/1999601/assignments/10006370?module_item_id=25352883

Based on the CS340 starter code and project steps 1-5 guidelines

### File Structure:
```
CS340-Term-Project/
- backend/                      # Node.js backend
    - app.js
    - db-connector.js           # These files are left "empty"
    - db.js                              
- frontend/                     # Web UI files
    - views
        - layouts
            - main.hbs
        - partials
            - nav.hbs
        customers.hbs
        index.hbs               # Main webpages
        orderitems.hbs          
        order.hbs
        products.hbs
    - style.css
- Diagrams/                     # ERDs
- MySQL_Workbench/              # .mwb files from MySQL Workbench
- .gitignore                       
- DDL.sql                       # Database schema + sample data
- data_manipulation_queries.sql # DML Documentation
- PL.sql                        # Stored Procedures 
- backup_DDL_dump.sql           # Full schema+data backup
- README.md                     # Project notes/documentation
```

## Diagrams

### ERD:
![Simple ERD Diagram](/Diagrams/PS2_ERD.png)

### Schema:
![Database Schema](/Diagrams/PS3_Schema.png)
