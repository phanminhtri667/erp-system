import { useState, useCallback, useRef } from 'react';
import { useForm, Controller } from 'react-hook-form';
import { Dropdown } from 'primereact/dropdown';
import { InputText } from 'primereact/inputtext';
import { Toast } from 'primereact/toast';
import { useDropzone } from 'react-dropzone';
import IconButton, { EButtonType } from '../../components/forms/button/IconButton';
import { ICreateProductPayload, productService } from '../../services/productServices';

interface ICategory {
  name: string;
  code: string;
}

export const CreateProduct = () => {
  const toast = useRef<Toast>(null);

  const {
    control,
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({
    defaultValues: {
      product_code: '',
      product_name: '',
      cost_price: '',
      selling_price: '',
      material: null,
      category: null,
      image: null,
    },
  });

  const [image, setImage] = useState<File | null>(null);
  const [imageBase64, setImageBase64] = useState<string | null>(null);

  const option: ICategory[] = [
    { name: 'Áo Thun', code: 'AT' },
    { name: 'Quần Dài', code: 'QD' },
    { name: 'Quần Short', code: 'QS' },
  ];

  // Khi người dùng kéo / chọn ảnh
  const onDrop = useCallback((acceptedFiles: File[]) => {
    const file = acceptedFiles[0];
    if (!file) return;

    setImage(file); // lưu để hiển thị preview

    const reader = new FileReader();
    reader.onload = () => {
      const base64 = reader.result as string;
      setImageBase64(base64); // lưu base64 để gửi API
    };
    reader.readAsDataURL(file);
  }, []);

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    accept: { 'image/*': [] },
    multiple: false,
    onDrop,
  });

  const onSubmit = async (data: any) => {
    console.log('imageBase64', imageBase64);

    try {
      const payload: ICreateProductPayload = {
        product_code: data.product_code,
        product_name: data.product_name,
        cost_price: Number(data.cost_price),
        selling_price: Number(data.selling_price),

        size_code: 'SIZE_L',
        color_code: 'CL002',
        material: data.material?.code || null,
        category: 'CAT001',
        images: imageBase64 ? [imageBase64] : [],
      };

      const result = await productService.createProduct(payload);
      if (result) {
        toast.current?.show({
          severity: 'success',
          summary: 'Thành công',
          detail: 'Tạo sản phẩm thành công!',
          life: 3000,
        });
      }
    } catch (error) {
      console.error(error);
      toast.current?.show({
        severity: 'error',
        summary: 'Lỗi',
        detail: 'Không thể tạo sản phẩm!',
        life: 3000,
      });
    }
  };

  return (
    <>
      <form onSubmit={handleSubmit(onSubmit)} className="p-6 bg-white rounded-2xl shadow-md">
        <h2 className="text-2xl font-semibold mb-6 text-gray-800">Thêm Sản Phẩm Mới</h2>

        {/* Mã & Tên sản phẩm */}
        <div className="grid grid-cols-2 gap-6">
          <div className="p-inputgroup">
            <div className="p-inputgroup">
              <span className="p-inputgroup-addon">
                <i className="pi pi-th-large"></i>
              </span>
              <InputText
                {...register('product_code', { required: 'Mã sản phẩm là bắt buộc' })}
                placeholder="Nhập Mã Sản Phẩm"
              />
              {errors.product_name && (
                <small className="p-error">{errors.product_name.message as string}</small>
              )}
            </div>
          </div>

          <div className="p-inputgroup">
            <span className="p-inputgroup-addon">
              <i className="pi pi-address-book"></i>
            </span>
            <InputText
              {...register('product_name', { required: 'Tên sản phẩm là bắt buộc' })}
              placeholder="Nhập Tên Sản Phẩm"
            />
            {/* {errors.product_name && (
              <small className="p-error">{errors.product_name.message as string}</small>
            )} */}
          </div>
        </div>

        {/* Giá */}
        <div className="grid grid-cols-2 gap-6 mt-4">
          <div className="p-inputgroup">
            <span className="p-inputgroup-addon">
              <i className="pi pi-dollar"></i>
            </span>
            <InputText {...register('cost_price')} type="number" placeholder="Giá Gốc" />
          </div>

          <div className="p-inputgroup">
            <span className="p-inputgroup-addon">
              <i className="pi pi-dollar"></i>
            </span>
            <InputText {...register('selling_price')} type="number" placeholder="Giá Bán" />
          </div>
        </div>

        {/* Dropdown chọn chất liệu & danh mục */}
        <div className="grid grid-cols-2 gap-6 mt-4">
          <Controller
            name="material"
            control={control}
            render={({ field }) => (
              <Dropdown
                {...field}
                value={field.value}
                onChange={(e) => field.onChange(e.value)}
                options={option}
                optionLabel="name"
                placeholder="Chọn Chất Liệu"
              />
            )}
          />

          <Controller
            name="category"
            control={control}
            render={({ field }) => (
              <Dropdown
                {...field}
                value={field.value}
                onChange={(e) => field.onChange(e.value)}
                options={option}
                optionLabel="name"
                placeholder="Chọn Danh Mục"
              />
            )}
          />
        </div>

        {/* Upload ảnh */}
        <div
          {...getRootProps()}
          className={`border-2 border-dashed rounded-xl p-6 text-center cursor-pointer transition mt-6 ${
            isDragActive
              ? 'border-purple-500 bg-purple-50'
              : 'border-gray-300 bg-gray-50 hover:bg-gray-100'
          }`}
        >
          <input {...getInputProps()} />
          {image ? (
            <div className="flex flex-col items-center">
              <img
                src={URL.createObjectURL(image)}
                alt="Preview"
                className="w-40 h-40 object-cover rounded-lg shadow-md mb-2"
              />
              <p className="text-gray-500 text-sm">{image.name}</p>
            </div>
          ) : (
            <p className="text-gray-500">
              {isDragActive ? 'Thả ảnh vào đây...' : 'Kéo & thả ảnh hoặc click để chọn ảnh'}
            </p>
          )}
        </div>

        {/* Nút tạo sản phẩm */}
        <div className="mt-8 text-right">
          <IconButton label="Thêm Mới" type={EButtonType.Submit} />
        </div>
      </form>
      <Toast ref={toast} />
    </>
  );
};
