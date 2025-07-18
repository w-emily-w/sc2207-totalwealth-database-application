CREATE TABLE Investor( 
  investor_phone_number NVARCHAR(10) PRIMARY KEY, 
  investor_name VARCHAR(255), 
  investor_gender CHAR(1), 
  investor_email VARCHAR(255), 
  investor_income FLOAT,  
  investor_company VARCHAR(255), 
  investor_dob DATE 
); 

CREATE TABLE RiskTolerance ( 
   phone_number NVARCHAR(10) NOT NULL, 
   risk_tolerance VARCHAR(20) NOT NULL, 
   question_id VARCHAR(10) NOT NULL, 
   answer_id VARCHAR(10) NOT NULL, 
     
   CONSTRAINT pk_risktolerance  
       PRIMARY KEY(phone_number, risk_tolerance,  question_id),  
    
   CONSTRAINT fk_risktolerance_phonenumber FOREIGN KEY(phone_number) 
       REFERENCES Investor(investor_phone_number), 
               
   CONSTRAINT fk_risktolerance_answer FOREIGN KEY(answer_id) 
       REFERENCES RiskToleranceAnswer(answer_id)   
             
   CONSTRAINT fk_risktolerance_question FOREIGN KEY(question_id) 
       REFERENCES RiskToleranceQuestion(question_id) 
); 

CREATE TABLE RiskToleranceQuestion( 
  question_id VARCHAR(10) NOT NULL, 
  question_description VARCHAR(255), 
  PRIMARY KEY(question_id) 
  CONSTRAINT fk_risktolerance_question FOREIGN KEY(question_id)  
       REFERENCES RiskToleranceQuestion(question_id), 
);

CREATE TABLE RiskToleranceAnswer( 
  answer_id VARCHAR(10) NOT NULL, 
  answer_description VARCHAR(255), 
  PRIMARY KEY(answer_id) 
); 

CREATE TABLE FinancialGoal( 
  portfolio_id VARCHAR(30), 
  goal VARCHAR(255), 
  timeline DATETIME, 
  amount_money DECIMAL(19, 4), 
  PRIMARY KEY(portfolio_id, goal), 
  CONSTRAINTS fk_financialgoal_portfolio FOREIGN KEY (portfolio_id)     
       REFERENCES Portfolio(portfolio_id)                                   
);

CREATE TABLE Portfolio( 
   phone_number NVARCHAR(10), 
   portfolio_id VARCHAR(30), 
   total_fund DECIMAL(19,4), 
   portfolio_status BIT, 
   market_value DECIMAL(19,4), 
   annual_return FLOAT,  
   created_date DATETIME, 
   PRIMARY KEY(portfolio_id), 
   CONSTRAINT fk_portfolio_phone_number FOREIGN KEY (phone_number)  
        REFERENCES Investor(investor_phone_number) 
); 

CREATE TABLE Asset( 
   portfolio_id VARCHAR(30) NOT NULL,  
   asset_id VARCHAR(30), 
   asset_name VARCHAR(20), 
   code VARCHAR(20), 
   price_now DECIMAL(19,4), 
   PRIMARY KEY (asset_id), 
   CONSTRAINT fk_asset_portfolio FOREIGN KEY (portfolio_id)  
        REFERENCES Portfolio(portfolio_id) 
); 

CREATE TABLE Stock ( 
   asset_id VARCHAR(30) PRIMARY KEY, 
   eps DECIMAL(10, 2) NOT NULL,               
   ebitda DECIMAL(15, 2) NOT NULL,            
   pe_ratio DECIMAL(10, 2) NOT NULL, 
   CONSTRAINT fk_stock_asset FOREIGN KEY (asset_id) 
        REFERENCES Asset(asset_id) 
);

CREATE TABLE Bond ( 
   asset_id VARCHAR(30) PRIMARY KEY,        
   interest_div DECIMAL(10, 2) NOT NULL, 
   maturity_date DATE NOT NULL, 
   CONSTRAINT fk_bond_asset FOREIGN KEY (asset_id) 
        REFERENCES Asset(asset_id) 
); 

CREATE TABLE Funds ( 
   asset_id VARCHAR(30) PRIMARY KEY, 
   div_yield DECIMAL(10, 2) NOT NULL, 
   expense_ratio FLOAT, 
   CONSTRAINT fk_funds_asset FOREIGN KEY (asset_id) 
        REFERENCES Asset(asset_id) 
); 

CREATE TABLE Fees ( 
   fee_id VARCHAR(30) PRIMARY KEY, 
   fee_amount DECIMAL(10, 2) NOT NULL, 
   fee_type VARCHAR(255) NOT NULL, 
   portfolio_id VARCHAR(30) NOT NULL, 
   CONSTRAINT fk_fees_portfolio FOREIGN KEY (portfolio_id) 
        REFERENCES Portfolio(portfolio_id) 
); 

CREATE TABLE Transactions ( 
   transaction_id INT PRIMARY KEY, 
   transaction_amount DECIMAL(10, 2) NOT NULL, 
   transaction_type VARCHAR(50) NOT NULL, 
   company VARCHAR(100), 
   portfolio_id VARCHAR(30) NOT NULL, 
   transaction_date DATE, 
   CONSTRAINT fk_transactions_portfolio FOREIGN KEY (portfolio_id) 
        REFERENCES Portfolio(portfolio_id) 
);

CREATE TABLE AllocationRatio( 
   portfolio_id VARCHAR(30) NOT NULL, 
   ratio_date DATETIME NOT NULL,  
   stocks_ratio FLOAT, 
   bonds_ratio FLOAT, 
   funds_ratio FLOAT, 
   PRIMARY KEY (portfolio_id, ratio_date), 
   CONSTRAINT fk_allocationratio_portfolio FOREIGN KEY (portfolio_id) 
        REFERENCES Portfolio(portfolio_id) 
); 

CREATE TABLE UnrealisedGainLoss ( 
   gainloss_date DATE NOT NULL, 
   gainloss_amount DECIMAL(19, 4) NOT NULL, 
   portfolio_id VARCHAR(30) NOT NULL, 
   PRIMARY KEY (portfolio_id, gainloss_date), 
   CONSTRAINT fk_unrealisedgainloss_portfolio FOREIGN KEY (portfolio_id) 
        REFERENCES Portfolio(portfolio_id) 
)
