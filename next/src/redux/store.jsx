"use client";

import { configureStore, getDefaultMiddleware } from "@reduxjs/toolkit";
import userReducer from "./features/userSlices";
import menuReducer from "./features/menusSlice";
import langReducer from "./features/langSlice";

const store = configureStore({
  reducer: {
    user: userReducer,
    menu: menuReducer,
    lang: langReducer,
  },
  middleware: (getDefaultMiddleware) => getDefaultMiddleware({
    serializableCheck: false
  }),
});

export default store;