// taskSlice.ts
import { createSlice, createAsyncThunk, PayloadAction } from "@reduxjs/toolkit";
import { RootState } from "./store";

// Define the task state
interface TaskProps {
  priority: string;
  task_type: number;
  barcode: string;
  task_name: string;
  project: string;
  status: string;
  verify: string;
  process: string;
  progress: string;
  md5_comp: string;
  character_check: string;
  archive_comp: boolean;
  restore_comp: boolean;
  verify_comp: boolean;
  src_count: number | null;
  dest_count: number;
  src_size: string | null;
  destsize: string;
  date_added: string;
  date_modified: string;
  process_start: string;
  lifecycle_status: string;
  hostname: string;
  task_id: number;
}

interface TaskState {
  taskData: TaskProps | null;
  loading: boolean;
  error: string | null;
}

// Define initial state
const initialState: TaskState = {
  taskData: null,
  loading: false,
  error: null,
};

// Create async thunk for fetching task data
export const fetchTaskData = createAsyncThunk(
  "task/fetchTaskData",
  async ({ taskId, hostname }: { taskId: number; hostname?: string }) => {
    const response = await fetch(
      `/api/lto_lifecycle/task?task_id=${taskId}&hostname=${hostname || ""}`
    );
    if (!response.ok) {
      throw new Error("Task not found");
    }
    return (await response.json()) as TaskProps;
  }
);

// Create slice
const taskSlice = createSlice({
  name: "task",
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(fetchTaskData.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(
        fetchTaskData.fulfilled,
        (state, action: PayloadAction<TaskProps>) => {
          state.taskData = action.payload;
          state.loading = false;
        }
      )
      .addCase(fetchTaskData.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message || "An error occurred";
      });
  },
});

export const selectTaskData = (state: RootState) => state.task.taskData;
export const selectTaskLoading = (state: RootState) => state.task.loading;
export const selectTaskError = (state: RootState) => state.task.error;

export default taskSlice.reducer;
