CREATE FILE FORMAT IF NOT EXISTS csv_format
  TYPE = 'CSV' 
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

-- SHOW FILE FORMATS;

CREATE OR REPLACE STAGE aws_snow_stage
FILE_FORMAT = csv_format
URL='your_s3_bucket_path';

-- SHOW STAGES;

COPY INTO bookings
FRoM @aws_snow_stage
FILES=('bookings.csv')
CREDENTIALS=(aws_key_id = 'yourkey', aws_secret_key = 'yoursecretkey');

COPY INTO listings
FRoM @aws_snow_stage
FILES=('listings.csv')
CREDENTIALS=(aws_key_id = 'yourkey', aws_secret_key = 'yoursecretkey');

COPY INTO hosts
FRoM @aws_snow_stage
FILES=('hosts.csv')
CREDENTIALS=(aws_key_id = 'yourkey', aws_secret_key = 'yoursecretkey');


-- SELECT * FROM BOOKINGS;

-- SELECT * FROM LISTINGS;

-- SELECT * FROM HOSTS;