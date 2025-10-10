import './employee.scss';
import DefaultLayout from '../../layouts/DefaultLayout';
import { Card } from 'primereact/card';
import { TabView, TabPanel } from 'primereact/tabview';
import EmployeeTable from './table/EmployeeTable';
import { useEffect, useRef, useState } from 'react';
import AxiosInstance from '../../services/axios';
import apiUrl from '../../constant/apiUrl';
import { Toast } from 'primereact/toast';
import { Dialog } from 'primereact/dialog';
import EmployeeCreate from './form/employeeCreate';
import EmployeeUpdate from './form/employeeUpdate';
import { InputText } from 'primereact/inputtext';
import { Button } from 'primereact/button';

const Employee = () => {
  const [employeeData, setEmployeeData] = useState<any[]>([]);
  const [filtered, setFiltered] = useState<any[]>([]);
  const [q, setQ] = useState<string>('');
  const [infoDataEmployee, setInfoDataEmployee] = useState<any>({});
  const [employeeSelected, setEmployeeSelected] = useState<any>({});
  const [visible, setVisible] = useState(false);
  const toast = useRef<Toast | null>(null);

  // Gọi API lấy danh sách nhân viên
  useEffect(() => {
    getEmployees();
  }, []);

  const getEmployees = async () => {
    try {
      const res = await AxiosInstance.get(apiUrl.employee.index);
      const rows = res.data.data || [];
      setEmployeeData(rows);
      setFiltered(rows);
      calcStatistic(rows);
    } catch (err) {
      console.error('Error fetching employees:', err);
    }
  };

  // Tính toán thống kê
  const calcStatistic = (data: any[]) => {
    const now = new Date().getTime();
    const newEmp = data.filter((e) => now - new Date(e.createdAt).getTime() < 24 * 3600 * 1000);
    const male = data.filter((e) => e.gender === 'male');
    setInfoDataEmployee({
      total: data.length,
      newEmployee: newEmp.length,
      male: male.length,
      female: data.length - male.length,
    });
  };

  // Tìm kiếm
  const handleSearch = (e: any) => {
    const kw = e.target.value.toLowerCase().trim();
    setQ(kw);
    if (!kw) return setFiltered(employeeData);
    setFiltered(employeeData.filter((x) => String(x.employee_id).toLowerCase().includes(kw)));
  };

  const clearSearch = () => {
    setQ('');
    setFiltered(employeeData);
  };

  // Mở popup sửa nhân viên
  const handleSelect = (emp: any) => {
    setEmployeeSelected(emp);
    setVisible(true);
  };

  return (
    <>
      <TabView>
        {/* TAB 1: DANH SÁCH NHÂN VIÊN */}
        <TabPanel header="List Employee">
          <div className="employee-container">
            {/* --- KHỐI THỐNG KÊ --- */}
            <div className="employee-header">
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">Total Employee</span>
                  <span className="card-body-content fs-2xl">{infoDataEmployee.total || 0}</span>
                </div>
              </Card>
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">New Employee</span>
                  <span className="card-body-content fs-2xl">
                    {infoDataEmployee.newEmployee || 0}
                  </span>
                </div>
              </Card>
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">Male</span>
                  <span className="card-body-content fs-2xl">{infoDataEmployee.male || 0}</span>
                </div>
              </Card>
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">Female</span>
                  <span className="card-body-content fs-2xl">{infoDataEmployee.female || 0}</span>
                </div>
              </Card>
            </div>

            {/* --- THANH TÌM KIẾM --- */}
            <Card className="search-card">
              <div className="search-bar">
                <span className="p-input-icon-left">
                  <i className="pi pi-search" />
                  <InputText
                    value={q}
                    onChange={handleSearch}
                    placeholder="Search by Employee ID (e.g., AD0001)"
                  />
                </span>
                <Button
                  label="Clear"
                  className="p-button-secondary p-button-sm clear-button"
                  onClick={clearSearch}
                  type="button"
                />
              </div>
            </Card>

            {/* --- BẢNG NHÂN VIÊN --- */}
            <div className="employee-table">
              <Card>
                <EmployeeTable data={filtered} onDelete={getEmployees} onSelect={handleSelect} />
              </Card>
            </div>
          </div>
        </TabPanel>

        {/* TAB 2: THÊM NHÂN VIÊN */}
        <TabPanel header="Add Employee">
          <div className="employee-form-card">
            <Card>
              <EmployeeCreate onSuccess={getEmployees} />
            </Card>
          </div>
        </TabPanel>
      </TabView>

      {/* POPUP CHỈNH SỬA NHÂN VIÊN */}
      <Dialog
        header="Edit Employee"
        visible={visible}
        style={{ width: '50vw' }}
        onHide={() => setVisible(false)}
      >
        <EmployeeUpdate
          data={employeeSelected}
          closeModal={() => setVisible(false)}
          getEmployee={getEmployees}
        />
      </Dialog>

      <Toast ref={toast} />
    </>
  );
};

export default Employee;
