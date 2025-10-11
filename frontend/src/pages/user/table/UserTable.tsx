import 'primeicons/primeicons.css';
import { Link } from 'react-router-dom';
import { ConfirmDialog, confirmDialog } from 'primereact/confirmdialog';
import { Toast } from 'primereact/toast';
import { useRef } from 'react';
import { deleteUser } from '../../../services/userService';

type Props = {
  data: any[];
  onDelete: () => void;
  onSelect: (employee: any) => void;
};

const UserTable = ({ data, onDelete, onSelect }: Props) => {
  const toast = useRef<Toast | null>(null);

  const handleDelete = async (user_code: string) => {
    try {
      await deleteUser(user_code);
      onDelete?.();
      toast.current?.show({
        severity: 'success',
        summary: 'Success',
        detail: 'User deleted successfully',
        life: 1500,
      });
    } catch (err) {
      console.error('Delete failed:', err);
      toast.current?.show({
        severity: 'error',
        summary: 'Error',
        detail: 'Delete failed',
        life: 1500,
      });
    }
  };

  const confirmDelete = (u: any) => {
    confirmDialog({
      message: `Do you want to delete user ${u.user_name}?`,
      header: 'Delete Confirmation',
      icon: 'pi pi-info-circle',
      acceptClassName: 'p-button-danger',
      accept: () => handleDelete(u.user_code),
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
            <th>User Code</th>
            <th>Full Name</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Role</th>
            <th>Created At</th>
            <th>Action</th>
          </tr>
        </thead>

        <tbody>
          {data.length ? (
            data.map((u, i) => (
              <tr key={u.user_code}>
                <td>{i + 1}</td>
                <td>{u.user_code}</td>
                <td>{u.user_name}</td>
                <td>{u.user_phone || '-'}</td>
                <td>{u.user_email || '-'}</td>
                <td>{u.role_code || '-'}</td>
                <td>{u.created_at ? new Date(u.created_at).toLocaleDateString('vi-VN') : '-'}</td>
                <td>
                  <div className="table-acction">
                    <Link to="#">
                      <i className="pi pi-eye pointer icon-hover" />
                    </Link>

                    <i
                      className="pi pi-pencil pointer icon-hover ml-3"
                      onClick={() => onSelect?.(u)}
                    />

                    <i
                      className="pi pi-trash pointer icon-hover ml-3"
                      onClick={() => confirmDelete(u)}
                    />
                  </div>
                </td>
              </tr>
            ))
          ) : (
            <tr>
              <td colSpan={8}>
                <p style={{ textAlign: 'center' }}>No data</p>
              </td>
            </tr>
          )}
        </tbody>
      </table>
    </>
  );
};

export default UserTable;
