import DefaultLayout from '../../../layouts/DefaultLayout';
import { useParams } from 'react-router-dom';
const EmployeeDetail = ({ ...props }) => {
  const params = useParams().employeeId;
  return (
    <>
      <div>
        <span>{params}</span>
      </div>
    </>
  );
};

export default EmployeeDetail;
