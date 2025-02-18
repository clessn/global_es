library(dplyr)
library(openai)

df <- readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_1965_raw.rds")

codebook <- sondr::sav_to_codebook(df)

i <- 2

model_name <- "gpt-4o"

for (i in 1:19) {

  raw_variable <- codebook$variable_name[i]
  raw_label <- codebook$question[i]
  raw_choices <- codebook$answers[i]
  table_output <- table(get(raw_variable, df))

  system_role <- "You are a highly skilled and meticulous data cleaning assistant specialized in processing survey data. Your task is to analyze survey variables and generate R code to clean and transform them according to strict specifications. Follow these rules:

1. **Input Analysis**:
   - Carefully examine the raw variable name, survey question, possible choices, and observed value distribution.
   - Determine if the variable should be cleaned as numeric (0-1 scaled) or binary (dummy variables).

2. **Decision Making**:
   - Use the survey question and possible choices to infer the variable type:
     - Numeric: Likert scales, ordinal rankings, or percentage estimates.
     - Binary: Distinct nominal categories without inherent order.
   - If the variable is ambiguous, default to binary dummy variables.

3. **Cleaning Rules**:
   - For numeric variables:
     - Scale values between 0 and 1, preserving ordinality (1 = most positive/affirmative).
     - Handle non-numeric or unexpected values as NA.
   - For binary variables:
     - Create one binary variable per category using exact string matching.
     - Ensure categories are mutually exclusive and exhaustive.

4. **Naming Conventions**:
   - Use the following prefix based on question context:
     - `ses`: Socioeconomic status (income, education, etc.)
     - `issue`: Policy or issue-related questions
     - `lifestyle`: Health, habits, or lifestyle
     - `vote`: Voting behavior or preferences
     - `leader`: Leader approval or traits
     - `party`: Political party affiliation
   - Variable names must be descriptive and indicate the direction of cleaning.
   - Suffix:
     - `_num` for numeric variables.
     - `_bin` for binary variables.

5. **Output Requirements**:
   - Generate R code using `dplyr` and `ifelse()` or `case_when()`.
   - Add comments to explain the cleaning logic and variable type decision.
   - Ensure the code is executable and handles all observed values.
   - Strictly follow naming conventions and formatting rules.

6. **Error Handling**:
   - If the input is ambiguous or incomplete, make reasonable assumptions and document them in comments.
   - Handle unexpected values gracefully (e.g., typos, missing data).

7. **Output Format**:
   - Only output R code with comments. Do not include explanations, markdown, or additional text.

Your goal is to produce clean, efficient, and well-documented R code that transforms raw survey data into analysis-ready variables. Always prioritize clarity, consistency, and adherence to the specifications."
  
  prompt <- paste0(
  "INSTRUCTIONS: Generate R code to clean the survey variable according to the specifications below.
  Raw variable name: ", raw_variable, "
  Survey question: ", raw_label, "
  Possible choices and associated raw values: ", raw_choices, "
  Observed value distribution:
  ", table_output, "
  
  REQUIREMENTS:
  1. Determine if this should be numeric (0-1 scaled) or binary dummy variables:
     - Numeric if: Likert scales, ordinal rankings, or percentage estimates
     - Binary if: Multiple distinct categories, nominal data, or yes/no questions
  
  2. For NUMERIC variables (suffix _num):
     - Scale between 0-1 preserving directionality (1=most positive/affirmative)
     - Handle non-numeric values appropriately
     - Example: c('Strongly disagree', 'Disagree') becomes c(0, 0.25)
  
  3. For BINARY variables (suffix _bin):
     - Create one binary variable per possible answer
     - Use ifelse() checks for exact matches
     - Name format: prefix_variableDescription_answer_bin
     - Example: 'urban' becomes area_type_urban_bin
  
  4. Naming rules:
     - Prefix: Identify category from question context:
       'ses' (socioeconomic), 'issue' (policy), 'lifestyle', 'vote', 'leader', 'party'
     - Variable name: Create descriptive lowercase name indicating direction
     - Example: 'lifestyle_watchHockey_bin' for watching hockey yes or no
     - Example: 'issue_proAbortion_num' for pro-abortion stance
  
  5. Special cases:
     - Handle NA/blank/missing appropriately
     - Preserve original ordering for ordinal data
     - Account for typos using exact string matching
     - Add comments explaining non-obvious decisions
  
  Generate R code using dplyr that:
  1. Processes df_raw$", raw_variable, "
  2. Creates appropriately named column(s) in df_clean
  3. Handles all observed values from the table
  4. Follows naming conventions strictly
  
  ONLY OUTPUT R CODE WITH COMMENTS, NO EXPLANATIONS."
  )


prompt_message <- list(
    list(
        role = "system", 
        content = system_role
    ),
    list(
        role = "user",
        content = prompt
    )
)
  # - use the openai package to prompt the model with the messages and store
  # - the output in a chat_prompt object.

  chat_prompt <- openai::create_chat_completion(
      model = model_name,
      messages = prompt_message
  )



}
