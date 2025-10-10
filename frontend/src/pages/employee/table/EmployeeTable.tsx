import 'primeicons/primeicons.css';
import { Link } from 'react-router-dom';
import { ConfirmDialog, confirmDialog } from 'primereact/confirmdialog';
import { Toast } from 'primereact/toast';
import { useRef } from 'react';
import AxiosInstance from '../../../services/axios';
import apiUrl from '../../../constant/apiUrl';

type Props = {
  data: any[];
  onDelete: () => void;
  onSelect: (employee: any) => void;
};

const EmployeeTable = ({ data, onDelete, onSelect }: Props) => {
  const toast = useRef<Toast | null>(null);

  const deleteEmployee = async (id: number) => {
    try {
      await AxiosInstance.delete(`${apiUrl.employee.index}/${id}`);
      onDelete?.();
      toast.current?.show({
        severity: 'success',
        summary: 'Success',
        detail: 'Employee deleted successfully',
        life: 1500,
      });
    } catch {
      toast.current?.show({
        severity: 'error',
        summary: 'Error',
        detail: 'Delete failed',
        life: 1500,
      });
    }
  };

  const confirmDelete = (emp: any) => {
    confirmDialog({
      message: `Do you want to delete employee ${emp.name}?`,
      header: 'Delete Confirmation',
      icon: 'pi pi-info-circle',
      acceptClassName: 'p-button-danger',
      accept: () => deleteEmployee(emp.id),
    });
  };

  return (
    <>
      <Toast ref={toast} />
      <ConfirmDialog />
      <table className="table">
        <thead>
          <tr>
            <th>#</th>
            <th>Full Name</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Bank Info</th>
            <th>Joined</th>
            <th>Seniority</th>
            <th>Total Salary</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {data.length ? (
            data.map((e, i) => (
              <tr key={e.id}>
                <td>{i + 1}</td>
                <td>{e.name}</td>
                <td>{e.phone}</td>
                <td>{e.address}</td>
                <td>
                  {e.bank_info?.bank_name}
                  <br />
                  <small>{e.bank_info?.account_no}</small>
                </td>
                <td>{e.joined_date}</td>
                <td>{e.seniority_years}</td>
                <td>{Number(e.total_salary_paid).toLocaleString('vi-VN')}</td>
                <td>
                  <div className="table-acction">
                    <Link to="#">
                      <i className="pi pi-eye pointer icon-hover" />
                    </Link>
                    <i
                      className="pi pi-pencil pointer icon-hover ml-3"
                      onClick={() => onSelect?.(e)}
                    />
                    <i
                      className="pi pi-trash pointer icon-hover ml-3"
                      onClick={() => confirmDelete(e)}
                    />
                  </div>
                </td>
              </tr>
            ))
          ) : (
            <tr>
              <td colSpan={9}>
                <p style={{ textAlign: 'center' }}>No data</p>
              </td>
            </tr>
          )}
        </tbody>
      </table>
    </>
  );
};

export default EmployeeTable;
