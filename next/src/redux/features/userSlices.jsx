import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  user: {},
  access: [],
};

const userSlice = createSlice({
    name: "user",
    initialState,
    reducers: {
        setUser: (state, action) => {
            state.user = action.payload;
        },
        setAccess: (state, action) => {
            state.access = action.payload;
        },
    },
});

export const { setUser, setAccess } = userSlice.actions;

export default userSlice.reducer;