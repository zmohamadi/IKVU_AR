import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  menus: [],
};

const menuSlice = createSlice({
    name: "menu",
    initialState,
    reducers: {
        setMenu: (state, action) => {
            state.userData = action.payload;
        },
    },
});

export const { setMenu } = menuSlice.actions;

export default menuSlice.reducer;