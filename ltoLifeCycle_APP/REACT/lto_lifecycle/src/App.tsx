import React from "react";
import TaskDetails from "./components/TaskDetails.tsx";

const App: React.FC = () => {
  const taskId = 22; // Replace with dynamic value
  const hostname = "khlto-003"; // Optional, replace with dynamic value if needed

  return (
    <div>
      <TaskDetails taskId={taskId} hostname={hostname} />
    </div>
  );
};

export default App;
