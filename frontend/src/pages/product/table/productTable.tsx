import "primeicons/primeicons.css";
import { Link } from "react-router-dom";
import { ConfirmDialog, confirmDialog } from "primereact/confirmdialog";
import { Toast } from "primereact/toast";
import { useRef } from "react";
import AxiosInstance from "../../../services/axios";
import apiUrl from "../../../constant/apiUrl";

type Props = {
  data: any[];
  onDelete: () => void;
  onSelect: (employee: any) => void;
};

const ProductTable = ({ data, onDelete, onSelect }: Props) => {
  const toast = useRef<Toast | null>(null);

  const deleteEmployee = async (id: number) => {
    try {
      await AxiosInstance.delete(`${apiUrl.employee.index}/${id}`);
      onDelete?.();
      toast.current?.show({
        severity: "success",
        summary: "Success",
        detail: "Employee deleted successfully",
        life: 1500,
      });
    } catch {
      toast.current?.show({
        severity: "error",
        summary: "Error",
        detail: "Delete failed",
        life: 1500,
      });
    }
  };

  const confirmDelete = (emp: any) => {
    confirmDialog({
      message: `Do you want to delete employee ${emp.name}?`,
      header: "Delete Confirmation",
      icon: "pi pi-info-circle",
      acceptClassName: "p-button-danger",
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
            <th>Product Code</th>
            <th>Product Name</th>
            <th>Images</th>
            <th>Category</th>
            <th>Min Price</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {data.length ? (
            data.map((e, i) => (
              <tr key={e.id}>
                <td>{i + 1}</td>
                <td>{e.name}</td>
                <td>{e.our_code}</td>
                <td><img height={'100px'} src={"https://bizweb.dktcdn.net/100/446/974/products/ao-thun-mlb-new-era-heavy-cotton-new-york-yankees-black-13086578-1.jpg?v=1691318321487"} alt={e.name} className="thumb" /> </td>
                 <td>{e.category}</td>
                <td>{e.min_price}</td>
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
                <p style={{ textAlign: "center" }}>No data</p>
              </td>
            </tr>
          )}
        </tbody>
      </table>
    </>
  );
};

export default ProductTable;
