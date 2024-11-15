import React, { useEffect } from "react";
import { useAppDispatch, useAppSelector } from "../store";
import {
  fetchTaskData,
  selectTaskData,
  selectTaskLoading,
  selectTaskError,
} from "../taskSlice";
import "../css/LTOTask.css";

const TaskDetails: React.FC<{ taskId: number; hostname?: string }> = ({
  taskId,
  hostname,
}) => {
  const dispatch = useAppDispatch();
  const taskData = useAppSelector(selectTaskData);
  const loading = useAppSelector(selectTaskLoading);
  const error = useAppSelector(selectTaskError);

  useEffect(() => {
    dispatch(fetchTaskData({ taskId, hostname }));
  }, [dispatch, taskId, hostname]);

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  if (error) {
    return <div className="error">Error: {error}</div>;
  }

  if (!taskData) {
    return null;
  }

  const statusColors: { [key: string]: string } = {
    COMPLETE: "green",
    PENDING: "orange",
    FAILED: "red",
    IN_PROGRESS: "blue",
    CANCELLED: "gray",
  };

  const progressValue = taskData.progress ? parseInt(taskData.progress, 10) : 0;

  return (
    <div className="task-details">
      <h1>Task Details</h1>
      <div className="task-details-grid">
        <div className="task-info">
          <div>
            <strong>Task ID:</strong> {taskData.task_id}
          </div>
          <div>
            <strong>Hostname:</strong> {taskData.hostname}
          </div>
          <div>
            <strong>Task Name:</strong> {taskData.task_name}
          </div>
          <div>
            <strong>Priority:</strong> {taskData.priority}
          </div>
          <div>
            <strong>Task Type:</strong> {taskData.task_type}
          </div>
          <div>
            <strong>Barcode:</strong> {taskData.barcode}
          </div>
          <div>
            <strong>Project:</strong> {taskData.project}
          </div>
        </div>
        <div className="task-status">
          <div
            className="status"
            style={{ backgroundColor: statusColors[taskData.status] || "gray" }}
          >
            <strong>Status:</strong> {taskData.status}
          </div>
          {taskData.progress && (
            <div className="progress-bar">
              <div
                className="progress"
                style={{ width: `${progressValue}%` }}
              ></div>
            </div>
          )}
        </div>
        <div className="task-counts">
          <div>
            <strong>Source Count:</strong> {taskData.src_count ?? "N/A"}
          </div>
          <div>
            <strong>Destination Count:</strong> {taskData.dest_count}
          </div>
          <div>
            <strong>Source Size:</strong> {taskData.src_size ?? "N/A"}
          </div>
          <div>
            <strong>Destination Size:</strong> {taskData.destsize}
          </div>
        </div>
        <div className="task-dates">
          <div>
            <strong>Date Added:</strong> {taskData.date_added}
          </div>
          <div>
            <strong>Date Modified:</strong> {taskData.date_modified}
          </div>
          <div>
            <strong>Process Start:</strong> {taskData.process_start}
          </div>
        </div>
        <div className="task-lifecycle-status">
          <div>
            <strong>Lifecycle Status:</strong> {taskData.lifecycle_status}
          </div>
        </div>
      </div>
    </div>
  );
};

export default TaskDetails;
