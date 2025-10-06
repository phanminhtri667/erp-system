import { createSlice, PayloadAction } from "@reduxjs/toolkit";

type User = {
  id: number;
  email: string;
  full_name: string;
  role_id?: number;
  role_code?: string;
};

type AuthState = {
  isAuthenticated: boolean;
  user: User | null;
};

// 👉 Lấy sẵn user từ localStorage khi app khởi động (để F5 không bị logout)
const savedUser = localStorage.getItem("user");
const initialState: AuthState = {
  isAuthenticated: !!savedUser,
  user: savedUser ? JSON.parse(savedUser) : null,
};

const authSlice = createSlice({
  name: "auth",
  initialState,
  reducers: {
    setUser(state, action: PayloadAction<User>) {
      state.isAuthenticated = true;
      state.user = action.payload;
      localStorage.setItem("user", JSON.stringify(action.payload));
    },
    logout(state) {
      state.isAuthenticated = false;
      state.user = null;
      localStorage.removeItem("user");
    },
  },
});

export const { setUser, logout } = authSlice.actions;
export default authSlice.reducer;
