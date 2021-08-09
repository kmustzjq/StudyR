transfer_character_to_numeric <- function(data_main){
  
  BLOCK_list = c("A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "P", "Q", "R", "S")
  ROW_list = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
               "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36",
               "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53",
               "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70",
               "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87",
               "88", "89", "90", "91", "92", "93", "94" )
  SLIDER_list = c("02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
                  "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36",
                  "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53",
                  "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70",
                  "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87",
                  "88", "89", "90" )
  
  
  SS1_EXP_TOOL_list = c("EXP21","EXP22")
  HTW_EXP_TOOL_list = c("EXP09","EXP14","EXP15")
  RIM_IBE_TOOL_list = c("IBE16-2","IBE17-2")
  
  
  data_main$BLOCK = as.numeric(factor(data_main$BLOCK, levels = BLOCK_list))
  data_main$ROW = as.numeric(factor(data_main$ROW, levels = ROW_list))
  data_main$SLIDER = as.numeric(factor(data_main$SLIDER, levels = SLIDER_list))
  
  
  data_main$SS1_EXP_TOOL = as.numeric(factor(data_main$SS1_EXP_TOOL, levels = SS1_EXP_TOOL_list))
  data_main$HTW_EXP_TOOL = as.numeric(factor(data_main$HTW_EXP_TOOL, levels = HTW_EXP_TOOL_list))
  data_main$RIM_IBE_TOOL = as.numeric(factor(data_main$RIM_IBE_TOOL, levels = RIM_IBE_TOOL_list))
  
  return(data_main)
}
