interface HomeProps {
  searchParams: Promise<{
    text?: string;
  }>
}

export default async function Home(props: HomeProps) {
  const searchParams = await props.searchParams;
  const searchText = searchParams.text || "no search"

  return (
    <div>{searchText}</div>
  );
}
