## 1 / What is PostgreSQL?

PostgreSQL একটি শক্তিশালী ওপেন-সোর্স রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম
(RDBMS)। এটি SQL (Structured Query Language) সাপোর্ট করার পাশাপাশি ডাটা টাইপ,
ডেটা সংরক্ষণ, অনুসন্ধান, আপডেট, এবং মুছার জন্য ব্যবহৃত হয়। এটি Oracle বা
MySQL-এর মতো ডাটাবেসের বিকল্প হিসেবে ব্যবহৃত হয়।

PostgreSQL এর featured :-

১/ ডেটা টেবিল আকারে সংরক্ষিত হয়, যেগুলো একটির Primary key অন্য টেবিলে Foreign
key হিসেবে বসে পরস্পরের সাথে সম্পর্ক স্থাপন করে।

২/ SQL (Structured Query Language) ব্যবহার করে ডেটা ম্যানিপুলেট করা যায়।

৩/ এটি একেবারে ফ্রি এবং সোর্স কোড কাস্টমাইজ করা যায়।

৪/ অত্যন্ত শক্তিশালী ও নির্ভরযোগ্য: বড় বড় কোম্পানি এবং সিস্টেম PostgreSQL
ব্যবহার করে।

৫/ ইউজার, অর্ডার, প্রোডাক্ট, ব্লগ পোস্ট — যে কোনো ধরনের ডেটা সংরক্ষণ করতে পারে।

৬/ কমপ্লেক্স কুয়েরি, ফিল্টারিং, সোর্টিং, জয়ন ইত্যাদি করতে পারে।

৭/ JSON, Array, Geolocation ইত্যাদির মতো অ্যাডভান্সড ডেটা টাইপ সাপোর্ট করে।

৮/ ট্রিগার, ভিউ, স্টোরড প্রসিডিউর — অ্যাডভান্সড ফিচারও রয়েছে।

### উদাহরণ:

```sql
CREATE TABLE blog_posts (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 2 / Explain the Primary Key and Foreign Key concepts in PostgreSQL.

Primary Key: এটি একটি কলাম বা কয়েকটি কলামের সমষ্টি যা একটি টেবিলের প্রতিটি
রেকর্ডকে ইউনিকভাবে আইডেন্টিফাই করার জন্য ব্যবহৃত হয় (যেমন: ranger_id)। এটি NULL
হতে পারে না এবং ডুপ্লিকেট ভ্যালু থাকতে পারে না।একটি টেবিলে একটিই প্রাইমারি কি
থাকে।

Foreign Key: একটি টেবিলের কলাম যা অন্য টেবিলের Primary Key-কে রেফারেন্স করে
(যেমন: sightings টেবিলে ranger_id)। এটি অন্য একটি টেবিলের প্রাইমারি কি-এর সাথে
সংযুক্ত থাকে এবং টেবিলগুলোর মধ্যে সম্পর্ক তৈরি করে। এটি ডেটা ইন্টেগ্রিটি বজায়
রাখতে সাহায্য করে।

### উদাহরণ:

```sql
CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  animal VARCHAR(100),
  ranger_id INT,
  FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id)
);

```

## 4/ What is the difference between the VARCHAR and CHAR data types?

### VARCHAR এবং CHAR উভয়ই PostgreSQL-এ স্ট্রিং ডেটা টাইপ, তবে এদের মধ্যে কিছু গুরুত্বপূর্ণ পার্থক্য আছে।

VARCHAR(n): এই ডেটা টাইপ ভ্যারিয়েবল-লেংথ স্ট্রিং রাখে, অর্থাৎ যতটুকু দরকার
ততটুকু জায়গা নেয়।যখন ডাটা দৈর্ঘ জানা থাকে না যেকোন দৈর্ঘ হতে পারে তখন ব্যবহার হয়
। যেমন নাম,ঠিকানা ইত্যাদি ।

CHAR(n): এটি ফিক্সড-লেংথ স্ট্রিং রাখে, এবং যদি কম ক্যারেক্টার দেওয়া হয়, তবে
বাকি জায়গা ফাঁকা (space) দিয়ে পূর্ণ হয়।সবসময় নির্দিষ্ট দৈর্ঘের string রাখে । →
সাধারণত VARCHAR বেশি ফ্লেক্সিবল এবং স্মার্ট মেমোরি ব্যবহারে কার্যকর।

### উদাহরণ:

```sql
CREATE TABLE customers (
  name_v VARCHAR(50),
  name_c CHAR(50)
);
```

## 5/ Explain the purpose of the WHERE clause in a SELECT statement.

SELECT স্টেটমেন্ট ব্যবহার করলে, ডেটাবেজের একটি টেবিল থেকে ডেটা আনা হয়।কিন্তু সব
সময় আমাদের পুরো টেবিলের সব ডেটা দরকার হয় না — আমরা চাই নির্দিষ্ট কিছু রেকর্ড,
যেগুলো কোনো শর্ত পূরণ করে।এই শর্তগুলো নির্ধারণ করতে WHERE ক্লজ ব্যবহার করা হয়।
এটি শর্ত সাপেক্ষে শুধুমাত্র প্রাসঙ্গিক রেকর্ড দেখায়/মডিফাই করে।

Where এ বিভিন্ন ধরনের শর্ত ব্যবহার হয় যেমন :- = ,<,>,<=,>=,!=,Between,like,in
ইত্যাদি ।

### উদাহরণ:

```sql
SELECT * FROM employees
WHERE salary > 50000 AND department = 'IT';
```

## 8 /What is the significance of the JOIN operation, and how does it work in PostgreSQL?

JOIN অপারেশন টেবিলগুলোর মধ্যে সম্পর্ক তৈরি করে এবং একাধিক টেবিল থেকে ডেটা একত্রে
দেখার সুযোগ দেয়। ডেটাবেইজে সাধারণত টেবিলগুলো আলাদা রাখা হয় (Normalization) ,
যেমন users, orders, products। কিন্তু রিপোর্ট বা ফলাফল তৈরি করতে একাধিক টেবিলের
ডেটা দরকার হয়। JOIN এই সম্পর্ক তৈরির মাধ্যমে আমাদের সব তথ্য একসাথে উপস্থাপন
করতে সাহায্য করে।

PostgreSQL-এ JOIN বিভিন্ন ধরনের হয়:

INNER JOIN: দুই টেবিলের মিল থাকা রেকর্ড দেখায়

LEFT JOIN: বাম টেবিলের সব রেকর্ড এবং ডান টেবিলের মিল থাকা রেকর্ড

RIGHT JOIN: ডান টেবিলের সব রেকর্ড এবং বাম টেবিলের মিল থাকা রেকর্ড

FULL JOIN: উভয় টেবিলের সব রেকর্ড → JOIN অপারেশন ডেটার মধ্যে সম্পর্ক বুঝতে এবং
রিপোর্ট তৈরিতে অপরিহার্য।

#### INNER JOIN:

```sql
SELECT users.name, orders.total
FROM users
INNER JOIN orders ON users.id = orders.user_id;

```

#### LEFT JOIN:

```sql
SELECT users.name, orders.total
FROM users
LEFT JOIN orders ON users.id = orders.user_id;


```

#### RIGHT JOIN:

```sql
SELECT users.name, orders.total
FROM users
RIGHT JOIN orders ON users.id = orders.user_id;
```

#### FULL JOIN:

```sql
SELECT users.name, orders.total
FROM users
FULL JOIN orders ON users.id = orders.user_id;


```
