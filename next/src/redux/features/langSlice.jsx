import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  langs: {},
  currentLang: "en"
};

const langSlice = createSlice({
    name: "lang",
    initialState,
    reducers: {
        setLangs: (state, action) => {
            state.langs = action.payload;
        },
        setCurrentLang: (state, action) => {
            state.currentLang = action.payload;
        },
    },
});

export const { setLangs, setCurrentLang } = langSlice.actions;

export default langSlice.reducer;