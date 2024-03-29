CREATE TYPE US_State AS ENUM (
        'AL',
        'AK',
        'AR',
        'AZ',
        'CA',
        'CO',
        'CT',
        'DC',
        'DE',
        'FL',
        'GA',
        'HI',
        'IA',
        'ID',
        'IL',
        'IN',
        'KS',
        'KY',
        'LA',
        'MA',
        'MD',
        'ME',
        'MI',
        'MN',
        'MO',
        'MS',
        'MT',
        'NC',
        'ND',
        'NE',
        'NH',
        'NJ',
        'NM',
        'NV',
        'NY',
        'OK',
        'OH',
        'OR',
        'PA',
        'RI',
        'SC',
        'SD',
        'TN',
        'TX',
        'UT',
        'VA',
        'VT',
        'WA',
        'WI',
        'WV',
        'WY');
CREATE TYPE User_Address (
    line_1  TEXT NOT NULL,
    line_2 TEXT NOT NULL,
    city TEXT NOT NULL
    us_state US_State NOT NULL,
    zip TEXT NOT NULL);
CREATE TYPE User_Role AS ENUM ('USER','ADMIN');
CREATE TYPE Sex AS ENUM ('FEMALE', 'MALE', 'OTHER');
CREATE TYPE MembershipType AS ENUM ('BASIC', 'SILVER','GOLD');

CREATE TABLE artworks (
    object_number INT PRIMARY KEY,
    artwork_title VARCHAR (256) UNIQUE NOT NULL,
    artist TEXT NOT NULL,
    culture TEXT NOT NULL,
    made_on DATE NOT NULL,
    object_type TEXT NOT NULL,
    art_department TEXT NOT NULL,
    dimensions TEXT NOT NULL
);

CREATE TABLE user_account (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR (256) NOT NULL, 
    last_name VARCHAR (256) NOT NULL,
    user_address User_Address NOT NULL, 
    email VARCHAR (256) NOT NULL,
    phone_number TEXT NOT NULL,
    sex Sex NOT NULL,
    date_of_birth DATE NOT NULL,
    membership MembershipType NOT NULL
);

CREATE TABLE gift_shop_item (
    gift_SKU TEXT PRIMARY KEY,
    gift_name TEXT NOT NULL,
    gift_type TEXT NOT NULL,
    gift_price NUMERIC NOT NULL
);

CREATE TABLE gift_shop_sales (
	gift_transaction_id UUID PRIMARY KEY,
	gift_SKU TEXT NOT NULL,
	gift_transaction_at TIMESTAMP NOT NULL,
	user_id UUID NOT NULL REFERENCES user_account(user_id)
);

CREATE TABLE gift_shop_item_inventory (
	gift_serial_number UUID PRIMARY KEY,
	gift_SKU TEXT NOT NULL REFERENCES gift_shop_item(gift_SKU),
	gift_transaction_id UUID REFERENCES gift_shop_sales(gift_transaction_id)
);


CREATE TABLE employees (
    employee_id UUID PRIMARY KEY,
    employee_membership MembershipType NOT NULL,
    employee_first_name VARCHAR (256) NOT NULL,  
    employee_last_name VARCHAR (256) NOT NULL,
    employee_address User_Address NOT NULL,
    employee_email VARCHAR (256) NOT NULL,
    employee_ssn TEXT NOT NULL,
    employee_phone_number INTEGER NOT NULL,
    employee_date_of_birth DATE NOT NULL,
    salary NUMERIC NOT NULL
);

CREATE TABLE exhibitions (
    exhibition_id UUID PRIMARY KEY,
    exhibition_at TIMESTAMP NOT NULL,
    exhibition_ticket_price NUMERIC NOT NULL,
    exhibition_gallery TEXT NOT NULL,
    exhibition_title TEXT NOT NULL,
    curator TEXT NOT NULL,
    exhibition_artists TEXT NOT NULL
);

CREATE TABLE exhibition_ticket_sales (
    exhibition_transaction_id UUID PRIMARY KEY, 
    user_id UUID NOT NULL REFERENCES user_account(user_id), 
    exhibition_id UUID NOT NULL REFERENCES exhibitions(exhibition_id),
    exhibition_transaction_at TIMESTAMP NOT NULL
);

CREATE TABLE films (
    film_id UUID PRIMARY KEY,
    viewing_at TIMESTAMP NOT NULL,
    film_title TEXT NOT NULL,
    film_ticket_price NUMERIC NOT NULL,
    duration_min INTEGER NOT NULL,
    film_director TEXT NOT NULL,
    film_rating TEXT NOT NULL
);

CREATE TABLE film_ticket_sales (
    film_transaction_id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES user_account(user_id),
    film_id UUID NOT NULL REFERENCES films(film_id),
    film_transaction_at TIMESTAMP NOT NULL
);

CREATE TABLE calendar (
    calendar_event_id UUID PRIMARY KEY,
    event_name TEXT NOT NULL,
    event_start DATE NOT NULL,
    event_end DATE NOT NULL,
    time_of_event_start TIME NOT NULL,
    time_of_event_end TIME NOT NULL,
    event_object_id UUID 
);

CREATE TABLE donation (
    donation_transaction_id UUID PRIMARY KEY,
    donator_first_name VARCHAR (256) NOT NULL,
    donator_last_name VARCHAR (256) NOT NULL,
    donator_email VARCHAR (256) NOT NULL,
    donation_on DATE NOT NULL,
    donation_amount NUMERIC NOT NULL
);

CREATE TABLE user_login (
    user_id UUID PRIMARY KEY REFERENCES user_account(user_id),
    user_role User_Role NOT NULL,
    user_name TEXT NOT NULL UNIQUE,
    hashed_password TEXT NOT NULL UNIQUE,
    login_email VARCHAR (256) NOT NULL,
    login_at TIMESTAMP NOT NULL
);
	
